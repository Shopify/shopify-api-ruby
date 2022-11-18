# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let("", String)
    @api_secret_key = T.let("", String)
    @api_version = T.let(LATEST_SUPPORTED_ADMIN_VERSION, String)
    @scope = T.let(Auth::AuthScopes.new, Auth::AuthScopes)
    @is_private = T.let(false, T::Boolean)
    @private_shop = T.let(nil, T.nilable(String))
    @is_embedded = T.let(true, T::Boolean)
    @logger = T.let(Logger.new($stdout), Logger)
    @notified_missing_resources_folder = T.let({}, T::Hash[String, T::Boolean])
    @active_session = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @session_storage = T.let(nil, T.nilable(ShopifyAPI::Auth::SessionStorage))
    @user_agent_prefix = T.let(nil, T.nilable(String))
    @old_api_secret_key = T.let(nil, T.nilable(String))

    @rest_resource_loader = T.let(nil, T.nilable(Zeitwerk::Loader))

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          api_version: String,
          scope: T.any(T::Array[String], String),
          is_private: T::Boolean,
          is_embedded: T::Boolean,
          logger: Logger,
          session_storage: T.nilable(ShopifyAPI::Auth::SessionStorage),
          host_name: T.nilable(String),
          host: T.nilable(String),
          private_shop: T.nilable(String),
          user_agent_prefix: T.nilable(String),
          old_api_secret_key: T.nilable(String),
        ).void
      end
      def setup(
        api_key:,
        api_secret_key:,
        api_version:,
        scope:,
        is_private:,
        is_embedded:,
        logger: Logger.new($stdout),
        session_storage: nil,
        host_name: nil,
        host: ENV["HOST"] || "https://#{host_name}",
        private_shop: nil,
        user_agent_prefix: nil,
        old_api_secret_key: nil
      )
        unless ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS.include?(api_version)
          raise Errors::UnsupportedVersionError,
            "Invalid version #{api_version}, supported versions: #{ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS}"
        end

        @api_key = api_key
        @api_secret_key = api_secret_key
        @api_version = api_version
        @host = T.let(host, T.nilable(String))
        @is_private = is_private
        @scope = Auth::AuthScopes.new(scope)
        @is_embedded = is_embedded
        @session_storage = session_storage
        if @session_storage
          ::ShopifyAPI::Context.logger.warn("The use of SessionStorage in the API library has been deprecated. " \
            "The ShopifyAPI will no longer have responsibility for session persistence. " \
            "Upgrading to `shopify_app` 21.3 will allow you to remove session_storage" \
            " from the API library Context configuration.")
        end
        @logger = logger
        @private_shop = private_shop
        @user_agent_prefix = user_agent_prefix
        @old_api_secret_key = old_api_secret_key

        load_rest_resources(api_version: api_version)
      end

      sig { params(api_version: String).void }
      def load_rest_resources(api_version:)
        # Unload any previous instances - mostly useful for tests where we need to reset the version
        @rest_resource_loader&.unload

        # No resources for the unstable version
        return if api_version == "unstable"

        version_folder_name = api_version.gsub("-", "_")
        path = "#{__dir__}/rest/resources/#{version_folder_name}"

        unless Dir.exist?(path)
          unless @notified_missing_resources_folder.key?(api_version)
            @logger.warn("Cannot autoload REST resources for API version '#{version_folder_name}', folder is missing")
            @notified_missing_resources_folder[api_version] = true
          end

          return
        end

        @rest_resource_loader = T.let(Zeitwerk::Loader.new, T.nilable(Zeitwerk::Loader))
        T.must(@rest_resource_loader).enable_reloading
        T.must(@rest_resource_loader).ignore("#{__dir__}/rest/resources")
        T.must(@rest_resource_loader).setup
        T.must(@rest_resource_loader).push_dir(path, namespace: ShopifyAPI)
        T.must(@rest_resource_loader).reload
      end

      sig { returns(String) }
      attr_reader :api_key, :api_secret_key, :api_version

      sig { returns(Auth::AuthScopes) }
      attr_reader :scope

      sig { returns(T.nilable(ShopifyAPI::Auth::SessionStorage)) }
      attr_reader :session_storage

      sig { returns(Logger) }
      attr_reader :logger

      sig { returns(T::Boolean) }
      def private?
        @is_private
      end

      sig { returns(T.nilable(String)) }
      attr_reader :private_shop, :user_agent_prefix, :old_api_secret_key, :host

      sig { returns(T::Boolean) }
      def embedded?
        @is_embedded
      end

      sig { returns(T::Boolean) }
      def setup?
        [api_key, api_secret_key, T.must(host)].none?(&:empty?)
      end

      sig { returns(T.nilable(Auth::Session)) }
      def active_session
        return @active_session.value unless @active_session.value.nil?

        private? ? Utils::SessionUtils.load_current_session : nil
      end

      sig { params(session: T.nilable(Auth::Session)).void }
      def activate_session(session)
        @active_session.value = session
      end

      sig { void }
      def deactivate_session
        @active_session.value = nil
      end

      sig { returns(String) }
      def host_scheme
        T.must(URI.parse(T.must(host)).scheme)
      end

      sig { returns(String) }
      def host_name
        T.must(URI(T.must(host)).host)
      end
    end
  end
end
