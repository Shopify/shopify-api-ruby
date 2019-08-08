# frozen_string_literal: true
module ShopifyAPI
  class ApiVersion < ActiveResource::Base
    class UnknownVersion < StandardError; end
    class InvalidVersion < StandardError; end
    class ApiVersionNotSetError < StandardError; end
    include Comparable

    self.site = "https://app.shopify.com/services/"
    self.primary_key = :handle

    HANDLE_FORMAT = /^\d{4}-\d{2}$/.freeze
    UNSTABLE_HANDLE = 'unstable'
    UNSTABLE_AS_DATE = Time.utc(3000, 1, 1)
    API_PREFIX = '/admin/api/'

    class << self
      attr_reader :versions

      def coerce_to_version(version_or_handle)
        return version_or_handle if version_or_handle.is_a?(ApiVersion)
        if @versions.nil?
          warn "[API VERSION WARNING] Known API Version set is empty. Initializing unvalidated version from handle."
          return ApiVersion.new(handle: version_or_handle)
        end

        @versions[version_or_handle.to_s].tap do |api_version|
          unless api_version
            raise ApiVersion::UnknownVersion, "UnknownVersion API version specified, `#{version_or_handle}`. \n Versions available: #{@versions.keys}"
          end
        end
      end

      def define_known_versions
        @versions = Meta.admin_versions.map { |version| [version.handle, version] }.to_h
      rescue ActiveResource::ConnectionError => e
        warn "[API VERSION WARNING] Could not fetch Admin API versions."
        warn "[API VERSION WARNING] #{e.message}"
        @versions = nil
      end

      def clear_defined_versions
        @versions = nil
      end

      def latest_stable_version
        warn(
          '[DEPRECATED] ShopifyAPI::ApiVersion.latest_stable_version is deprecated and will be removed in a future version.'
        )
        @versions.values.find(&:latest_supported?)
      end
    end

    def initialize(attributes = {}, persisted = false)
      super
      @attributes['handle'] = @attributes['handle'].to_s
      @attributes['display_name'] = @attributes['handle'].to_s unless @attributes.key?('display_name')
      @attributes['supported'] = false unless @attributes.key?('supported')
      @attributes['latest_supported'] = false unless @attributes.key?('latest_supported')
    end

    def to_s
      handle
    end

    def <=>(other)
      handle_as_date <=> other.handle_as_date
    end

    def ==(other)
      other.class == self.class && handle == other.handle
    end

    def hash
      handle.hash
    end

    def construct_api_path(path)
      "#{API_PREFIX}#{handle}/#{path}"
    end

    def construct_graphql_path
      construct_api_path('graphql.json')
    end

    def name
      warn(
        '[DEPRECATED] ShopifyAPI::ApiVersion#name is deprecated and will be removed in a future version. ' \
          'Use `handle` instead.'
      )
      handle
    end

    def stable?
      warn(
        '[DEPRECATED] ShopifyAPI::ApiVersion#stable? is deprecated and will be removed in a future version. ' \
          'Use `supported?` instead.'
      )
      supported?
    end

    def unstable?
      handle == UNSTABLE_HANDLE
    end

    def handle_as_date
      return UNSTABLE_AS_DATE if unstable?
      year, month, day = handle.split('-')
      Time.utc(year, month, day)
    end

    class NullVersion
      class << self
        def stable?
          raise ApiVersionNotSetError, "You must set ShopifyAPI::Base.api_version before making a request."
        end

        def construct_api_path(*_path)
          raise ApiVersionNotSetError, "You must set ShopifyAPI::Base.api_version before making a request."
        end

        def construct_graphql_path
          raise ApiVersionNotSetError, "You must set ShopifyAPI::Base.api_version before making a request."
        end
      end
    end
  end
end
