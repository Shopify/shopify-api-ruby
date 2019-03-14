require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    class InvalidSessionError < StandardError; end
    extend Countable

    self.timeout = 90
    self.include_root_in_json = false
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    API_PREFIX = '/admin/'.freeze

    def encode(options = {})
      same = dup
      same.attributes = {self.class.element_name => same.attributes} if self.class.format.extension == 'json'

      same.send("to_#{self.class.format.extension}", options)
    end

    def as_json(options = nil)
      root = options[:root] if options.try(:key?, :root)
      if include_root_in_json
        root = self.class.model_name.element if root == true
        { root => serializable_hash(options) }
      else
        serializable_hash(options)
      end
    end

    class << self
      if ActiveResource::Base.respond_to?(:_headers) && ActiveResource::Base.respond_to?(:_headers_defined?)
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
        self.password = nil
        self.user = nil
        self.headers.delete('X-Shopify-Access-Token')
      end

      def api_prefix
        API_PREFIX
      end

      def prefix(options = {})
        "#{api_prefix}#{resource_prefix(options)}"
      end

      def prefix_source
        ''
      end

      def resource_prefix(_options = {})
        ''
      end

      # Sets the \prefix for a resource's nested URL (e.g., <tt>prefix/collectionname/1.json</tt>).
      # Default value is <tt>site.path</tt>.
      def resource_prefix=(value)
        @prefix_parameters = nil

        resource_prefix_call = value.gsub(/:\w+/) { |key| "\#{URI.parser.escape options[#{key}].to_s}" }

        silence_warnings do
          # Redefine the new methods.
          instance_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
            def prefix_source() "#{value}" end
            def resource_prefix(options={}) "#{resource_prefix_call}" end
          RUBY_EVAL
        end
      rescue => e
        logger&.error("Couldn't set prefix: #{e}\n  #{code}")
        raise
      end

      alias_method :set_prefix, :resource_prefix=
      alias_method :prefix=, :resource_prefix=

      def init_prefix(resource)
        init_prefix_explicit(resource.to_s.pluralize, "#{resource}_id")
      end

      def init_prefix_explicit(resource_type, resource_id)
        self.prefix = "#{resource_type}/:#{resource_id}/"

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
