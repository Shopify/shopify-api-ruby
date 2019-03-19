module ShopifyAPI
  class ApiVersion
    class NoVersion < ApiVersion
      API_PREFIX = '/admin/'.freeze

      def initialize
        @version_name = "no version"
      end

      def construct_api_path(path)
        "#{API_PREFIX}#{path}"
      end
    end

    class Unstable < ApiVersion
      API_PREFIX = '/admin/api/'.freeze

      def initialize
        @version_name = "unstable"
        @url = "#{API_PREFIX}unstable/"
      end

      def construct_api_path(path)
        "#{@url}#{path}"
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
  end
end
