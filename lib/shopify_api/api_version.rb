# frozen_string_literal: true
module ShopifyAPI
  class ApiVersion
    class UnknownVersion < StandardError; end
    class InvalidVersion < StandardError; end

    include Comparable

    def self.coerce_to_version(version_or_name)
      return version_or_name if version_or_name.is_a?(ApiVersion)

      @versions ||= {}
      @versions.fetch(version_or_name.to_s) do
        raise UnknownVersion, "#{version_or_name} is not in the defined version set: #{@versions.keys.join(', ')}"
      end
    end

    def self.define_version(version)
      @versions ||= {}

      @versions[version.name] = version
    end

    def self.clear_defined_versions
      @versions = {}
    end

    def self.define_known_versions
      define_version(NoVersion.new)
      define_version(Unstable.new)
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

    def construct_api_path(_path)
      raise NotImplementedError
    end

    def construct_graphql_path
      raise NotImplementedError
    end

    protected

    attr_reader :numeric_version

    class NoVersion < ApiVersion
      API_PREFIX = '/admin/'

      def initialize
        @version_name = "no_version"
        @numeric_version = 0
      end

      def construct_api_path(path)
        "#{API_PREFIX}#{path}"
      end

      def construct_graphql_path
        '/admin/api/graphql.json'
      end
    end

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

      def construct_api_path(path)
        "#{@url}#{path}"
      end

      def construct_graphql_path
        construct_api_path('graphql.json')
      end
    end
  end
end
