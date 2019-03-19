module ShopifyAPI
  class ApiVersion
    class NoVersion < ApiVersion
      API_PREFIX = '/admin/'
      GRAPHQL_PATH = '/admin/api/graphql.json'

      def initialize
        @version_name = "no version"
      end

      def construct_api_path(path)
        "#{API_PREFIX}#{path}"
      end

      def construct_graphql_path
        GRAPHQL_PATH
      end
    end

    class Unstable < ApiVersion
      API_PREFIX = '/admin/api/unstable/'

      def initialize
        @version_name = "unstable"
      end

      def construct_api_path(path)
        "#{API_PREFIX}#{path}"
      end

      def construct_graphql_path
        construct_api_path('graphql.json')
      end
    end

    def self.no_version
      NoVersion.new
    end

    def self.unstable
      Unstable.new
    end

    def to_s
      @version_name
    end

    def inspect
      @version_name
    end

    def ==(other)
      other.class == self.class && to_s == other.to_s
    end

    def hash
      version_name.hash
    end

    def construct_api_path(_path)
      raise NotImplementedError
    end

    def construct_graphql_path
      raise NotImplementedError
    end
  end
end
