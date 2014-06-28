require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    class InvalidSessionError < StandardError; end
    extend Countable
    self.include_root_in_json = true
    class_attribute :include_only_top_root_in_json
    self.include_only_top_root_in_json = true
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    def as_json(options = nil)
      root = options[:root] if options.try(:key?, :root)
      root = self.class.model_name.element if root == true
      if root && include_root_in_json
        options.delete(:root) if include_only_top_root_in_json
        { root => serializable_hash(options) }
      else
        serializable_hash(options)
      end
    end

    class << self
      if ActiveResource::VERSION::MAJOR == 4 && ActiveResource::VERSION::PRE == 'threadsafe'
        def headers
          if _headers_defined?
            _headers
          elsif superclass != Object && superclass.headers
            superclass.headers
          else
            _headers ||= {}
          end
        end
      else
        def headers
          if defined?(@headers)
            @headers
          elsif superclass != Object && superclass.headers
            superclass.headers
          else
            @headers ||= {}
          end
        end
      end

      def activate_session(session)
        raise InvalidSessionError.new("Session cannot be nil") if session.nil?
        self.site = session.site
        self.headers.merge!('X-Shopify-Access-Token' => session.token)
      end

      def clear_session
        self.site = nil
        self.headers.delete('X-Shopify-Access-Token')
      end

      def init_prefix(resource)
        init_prefix_explicit(resource.to_s.pluralize, "#{resource}_id")
      end

      def init_prefix_explicit(resource_type, resource_id)
        self.prefix = "/admin/#{resource_type}/:#{resource_id}/"

        define_method resource_id.to_sym do
          @prefix_options[resource_id]
        end
      end
    end

    def persisted?
      !id.nil?
    end

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
