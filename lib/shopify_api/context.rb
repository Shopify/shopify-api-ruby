# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let("", String)
    @api_secret_key = T.let("", String)
    @api_version = T.let("2021-01", String)
    @host_name = T.let("", String)
    @scope = T.let(Auth::AuthScopes.new, Auth::AuthScopes)
    @is_embedded = T.let(false, T::Boolean)
    @session_storage = T.let(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Auth::SessionStorage)
    @is_private = T.let(false, T::Boolean)
    @private_shop = T.let(nil, T.nilable(String))
    @is_embedded = T.let(true, T::Boolean)
    @logger = T.let(Logger.new(STDOUT), Logger)
    @notified_missing_resources_folder = T.let({}, T::Hash[String, T::Boolean])

    @rest_wrapper_loader = T.let(nil, T.nilable(Zeitwerk::Loader))

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          api_version: String,
          host_name: String,
          scope: T.any(T::Array[String], String),
          is_private: T::Boolean,
          is_embedded: T::Boolean,
          session_storage: ShopifyAPI::Auth::SessionStorage,
          logger: Logger,
          private_shop: T.nilable(String)
        ).void
      end
      def setup(
        api_key:,
        api_secret_key:,
        api_version:,
        host_name:,
        scope:,
        is_private:,
        is_embedded:,
        session_storage:,
        logger: Logger.new(STDOUT),
        private_shop: nil
      )
        @api_key = api_key
        @api_secret_key = api_secret_key
        @api_version = api_version
        @host_name = host_name
        @is_private = is_private
        @scope = Auth::AuthScopes.new(scope)
        @is_embedded = is_embedded
        @session_storage = session_storage
        @logger = logger
        @private_shop = private_shop

        load_rest_wrappers(api_version: api_version)
      end

      sig { params(api_version: String).void }
      def load_rest_wrappers(api_version:)
        version_folder_name = api_version.gsub("-", "_")
        path = "lib/shopify_api/rest_wrappers/resources/#{version_folder_name}"

        unless Dir.exist?(path)
          unless @notified_missing_resources_folder.key?(api_version)
            @logger.warn("Cannot autoload REST resources for API version '#{version_folder_name}', folder is missing")
            @notified_missing_resources_folder[api_version] = true
          end

          return
        end

        # Unload any previous instances - mostly useful for tests where we need to reset the version
        @rest_wrapper_loader&.unload

        @rest_wrapper_loader = T.let(Zeitwerk::Loader.new, T.nilable(Zeitwerk::Loader))
        T.must(@rest_wrapper_loader).enable_reloading
        T.must(@rest_wrapper_loader).ignore("#{__dir__}/rest_wrappers/resources")
        T.must(@rest_wrapper_loader).setup
        T.must(@rest_wrapper_loader).push_dir(path, namespace: ShopifyAPI)
        T.must(@rest_wrapper_loader).reload
      end

      sig { returns(String) }
      attr_reader :api_key, :api_secret_key, :api_version, :host_name

      sig { returns(Auth::AuthScopes) }
      attr_reader :scope

      sig { returns(ShopifyAPI::Auth::SessionStorage) }
      attr_reader :session_storage

      sig { returns(Logger) }
      attr_reader :logger

      sig { returns(T::Boolean) }
      def private?
        @is_private
      end

      sig { returns(T.nilable(String)) }
      attr_reader :private_shop

      sig { returns(T::Boolean) }
      def embedded?
        @is_embedded
      end

      sig { returns(T::Boolean) }
      def setup?
        !(api_key.empty? || api_secret_key.empty? || host_name.empty?)
      end
    end
  end
end
