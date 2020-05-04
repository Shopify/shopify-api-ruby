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

    CURSOR_VERSIONS = {
      '2019-07' => %w[
        Collect
        Collectionlisting
        Collection
        CustomerSavedSearch
        Event
        Metafield
        Product
        Productlisting
        ProductVariants
      ],
      '2019-10' => %w[
        Checkout
        Article
        Blog
        Comment
        Customer
        CustomCollection
        DiscountCode
        DraftOrder
        Fulfillment
        GiftCard
        Order
        OrderRisk
        Page
        PriceRule
        Variant
        Redirect
        Refund
        ScriptTag
        SmartCollection
        Transaction
        Webhook
      ]
    }

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
      alias next all
      alias previous all

      threadsafe_attribute(:api_version)
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

      def cursor_based?(api_ver = nil)
        # ShopifyAPI::Base.api_version - for using in subclasses
        api_ver ||= api_version.presence || ShopifyAPI::Base.api_version
        !!CURSOR_VERSIONS[api_ver]&.include?(to_s.split('::').last)
      end

      def all(*args)
        options = args.slice!(0) || {}

        if cursor_based?
          options = options.with_indifferent_access
          if options[:params].present?
            options[:params].delete :page

            options[:params].slice!(:page_info, :limit, :fields) if options.dig(:params, :page_info).present?

            options[:params].delete_if { |_k, v| v.nil? }
          end
        end

        find :all, *([options] + args)
      end

      def activate_session(session)
        raise InvalidSessionError.new("Session cannot be nil") if session.nil?
        self.site = session.site
        self.api_version = session.api_version
        self.headers.merge!('X-Shopify-Access-Token' => session.token)
      end

      def clear_session
        self.site = nil
        self.api_version = nil
        self.password = nil
        self.user = nil
        self.headers.delete('X-Shopify-Access-Token')
      end

      def init_prefix(resource)
        init_prefix_explicit(resource.to_s.pluralize, "#{resource}_id")
      end

      def init_prefix_explicit(resource_type, resource_id)
        self.prefix = "/admin/api/#{api_version}/#{resource_type}/:#{resource_id}/"

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
