# frozen_string_literal: true
module ShopifyAPI
  class ApiVersion
    class InvalidVersion < StandardError; end
    include Comparable

    def self.__coercer
      @coercer ||= VersionCoercers::GenerateRelease.new
    end

    def self.coercer=(version_coercer)
      @coercer = version_coercer
    end

    def self.coerce_to_version(version_or_name)
      __coercer.coerce_to_version(version_or_name)
    end

    def self.define_version(version)
      warn(
        '[DEPRECATED] ShopifyAPI::ApiVersion.define_version is deprecated ' \
        'call define_version on the Coercer you assigned'
      )
      __coercer.define_version(version)
    end

    def self.clear_defined_versions
      warn(
        '[DEPRECATED] ShopifyAPI::ApiVersion.clear_defined_versions is deprecated ' \
        'use ShopifyAPI::ApiVersion.versions.clear_defined_versions instead.'
      )
      __coercer.clear_defined_versions
    end

    def to_s
      @version_name
    end
    alias_method :name, :to_s

    def inspect
      @version_name
    end

    def ==(other)
      other.class == self.class && to_s == other.to_s
    end

    def hash
      @version_name.hash
    end

    def <=>(other)
      numeric_version <=> other.numeric_version
    end

    def stable?
      false
    end

    def construct_api_path(_path)
      raise NotImplementedError
    end

    def construct_graphql_path
      raise NotImplementedError
    end

    protected

    attr_reader :numeric_version

    class Unstable < ApiVersion
      API_PREFIX = '/admin/api/unstable/'

      def initialize
        @version_name = "unstable"
        @url = API_PREFIX
        @numeric_version = 9_000_00
      end

      def construct_api_path(path)
        "#{@url}#{path}"
      end

      def construct_graphql_path
        construct_api_path("graphql.json")
      end
    end

    class Release < ApiVersion
      FORMAT = /^\d{4}-\d{2}$/.freeze
      API_PREFIX = '/admin/api/'

      def initialize(version_number)
        raise InvalidVersion, version_number unless version_number.match(FORMAT)
        @version_name = version_number
        @url = "#{API_PREFIX}#{version_number}/"
        @numeric_version = version_number.tr('-', '').to_i
      end

      def stable?
        true
      end

      def construct_api_path(path)
        "#{@url}#{path}"
      end

      def construct_graphql_path
        construct_api_path('graphql.json')
      end
    end
  end
end
