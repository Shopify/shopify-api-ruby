# frozen_string_literal: true
module ShopifyAPI
  class ApiVersion
    class UnknownVersion < StandardError; end
    class InvalidVersion < StandardError; end
    include Comparable

    HANDLE_FORMAT = /^\d{4}-\d{2}$/.freeze
    UNSTABLE_HANDLE = 'unstable'
    UNSTABLE_AS_DATE = Time.utc(3000, 1, 1)
    API_PREFIX = '/admin/api/'
    COERSION_MODES = [:predefined_only, :define_on_unknown].freeze

    class << self
      attr_reader :coercion_mode

      def versions
        @versions ||= @coercer.known_versions
      end

      def coercer
        @coercer ||= VersionCoercers::GenerateVersion.new
      end

      def coercion_mode=(mode)
        raise ArgumentError, "Mode must be one of #{COERSION_MODES}" unless COERSION_MODES.include?(mode)
        @coercion_mode = mode
        if :predefined_only == mode
          coercer = VersionCoercers::DefinedOnly.new
        else
          coercer = VersionCoercers::GenerateVersion.new
        end
      end

      def coerce_to_version(version_or_handle)
        coercer.coerce_to_version(version_or_handle)
      end

      def fetch_known_versions
        coercer.fetch_known_versions
      end

      def define_known_versions
        warn(
          '[DEPRECATED] ShopifyAPI::ApiVersion.define_known_versions is deprecated and will be removed in a future version. ' \
            'Use `fetch_known_versions` instead.'
        )
        fetch_known_versions
      end

      def clear_known_versions
        coercer.clear_known_versions
      end

      def clear_defined_versions
        warn(
          '[DEPRECATED] ShopifyAPI::ApiVersion.clear_defined_versions is deprecated and will be removed in a future version. ' \
            'Use `clear_known_versions` instead.'
        )
        clear_known_versions
      end


      def latest_stable_version
        warn(
          '[DEPRECATED] ShopifyAPI::ApiVersion.latest_stable_version is deprecated and will be removed in a future version.'
        )
        versions.values.find(&:latest_supported?)
      end
    end

    attr_reader :handle, :display_name, :supported, :latest_supported, :verified

    def initialize(attributes)
      attributes = ActiveSupport::HashWithIndifferentAccess.new(attributes)
      @handle = attributes[:handle].to_s
      @display_name = attributes.fetch(:display_name, attributes[:handle].to_s)
      @supported = attributes.fetch(:supported, false)
      @latest_supported = attributes.fetch(:latest_supported, false)
      @verified = attributes.fetch(:verified, false)
    end

    def to_s
      handle
    end

    def latest_supported?
      latest_supported
    end

    def supported?
      supported
    end

    def verified?
      verified
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
  end
end
