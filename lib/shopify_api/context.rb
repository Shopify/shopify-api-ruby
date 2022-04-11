# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let("", String)
    @api_secret_key = T.let("", String)
    @api_version = T.let(LATEST_SUPPORTED_ADMIN_VERSION, String)
    @host_name = T.let("", String)
    @scope = T.let(Auth::AuthScopes.new, Auth::AuthScopes)
    @session_storage = T.let(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Auth::SessionStorage)
    @is_private = T.let(false, T::Boolean)
    @private_shop = T.let(nil, T.nilable(String))
    @is_embedded = T.let(true, T::Boolean)
    @logger = T.let(Logger.new($stdout), Logger)
    @notified_missing_resources_folder = T.let({}, T::Hash[String, T::Boolean])
    @active_session = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @user_agent_prefix = T.let(nil, T.nilable(String))

    @rest_resource_loader = T.let(nil, T.nilable(Zeitwerk::Loader))

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
          private_shop: T.nilable(String),
          user_agent_prefix: T.nilable(String),
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
        logger: Logger.new($stdout),
        private_shop: nil,
        user_agent_prefix: nil
      )
        unless ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS.include?(api_version)
          raise Errors::UnsupportedVersionError,
            "Invalid vession #{api_version}, supported versions: #{ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS}"
        end

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
        @user_agent_prefix = user_agent_prefix

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
      attr_reader :private_shop, :user_agent_prefix

      sig { returns(T::Boolean) }
      def embedded?
        @is_embedded
      end

      sig { returns(T::Boolean) }
      def setup?
        !(api_key.empty? || api_secret_key.empty? || host_name.empty?)
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
    end
  end
end
