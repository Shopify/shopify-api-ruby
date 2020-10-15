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

    self.collection_parser = ShopifyAPI::PaginatedCollection

    def encode(options = {})
      same = dup
      same.attributes = { self.class.element_name => same.attributes } if self.class.format.extension == 'json'

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
      threadsafe_attribute(:_api_version)
      def headers
        if _headers_defined?
          _headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          _headers ||= {}
        end
      end

      def activate_session(session)
        raise InvalidSessionError, "Session cannot be nil" if session.nil?
        self.site = session.site
        self.headers.merge!('X-Shopify-Access-Token' => session.token)
        self.api_version = session.api_version
      end

      def clear_session
        self.site = nil
        self.password = nil
        self.user = nil
        self.headers.delete('X-Shopify-Access-Token')
      end

      def api_version
        if _api_version_defined?
          _api_version
        elsif superclass != Object && superclass.site
          superclass.api_version.dup.freeze
        else
          ApiVersion::NullVersion
        end
      end

      def api_version=(version)
        self._api_version = ApiVersion::NullVersion.matches?(version) ? ApiVersion::NullVersion : ApiVersion.find_version(version)
      end

      def prefix(options = {})
        api_version.construct_api_path(resource_prefix(options))
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

        resource_prefix_call = value.gsub(/:\w+/) { |key| "\#{URI::DEFAULT_PARSER.escape options[#{key}].to_s}" }

        silence_warnings do
          # Redefine the new methods.
          instance_eval(<<-RUBY_EVAL, __FILE__, __LINE__ + 1)
            def prefix_source() "#{value}" end
            def resource_prefix(options={}) "#{resource_prefix_call}" end
          RUBY_EVAL
        end
      rescue => e
        logger&.error("Couldn't set prefix: #{e}\n  #{code}")
        raise
      end

      def prefix=(value)
        if value.start_with?('/admin')
          raise ArgumentError, "'#{value}' can no longer start /admin/. Change to using resource_prefix="
        end

        warn(
          '[DEPRECATED] ShopifyAPI::Base#prefix= is deprecated and will be removed in a future version. ' \
            'Use `self.resource_prefix=` instead.'
        )
        self.resource_prefix = value
      end

      alias_method :set_prefix, :prefix=

      def init_prefix(resource)
        init_prefix_explicit(resource.to_s.pluralize, "#{resource}_id")
      end

      def init_prefix_explicit(resource_type, resource_id)
        self.resource_prefix = "#{resource_type}/:#{resource_id}/"

        define_method(resource_id.to_sym) do
          @prefix_options[resource_id]
        end
      end

      def early_july_pagination?
        !!early_july_pagination
      end

      def version_validation!(minimum_version)
        available_in_version = ShopifyAPI::ApiVersion.find_version(minimum_version)

        unless ShopifyAPI::Base.api_version >= available_in_version
          raise NotImplementedError, "The minimum supported version is #{minimum_version}."
        end
      end

      private

      attr_accessor :early_july_pagination

      def early_july_pagination_release!
        self.early_july_pagination = true
      end
    end

    def persisted?
      !id.nil?
    end

    private

    def only_id
      encode(only: :id, include: [], methods: [])
    end
  end
end
