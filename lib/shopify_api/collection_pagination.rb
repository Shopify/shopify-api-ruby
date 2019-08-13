module ShopifyAPI
  module CollectionPagination

    def initialize(args)
      @previous_url_params = extract_url_params(pagination_link_headers.previous_link)
      @next_url_params = extract_url_params(pagination_link_headers.next_link)
      super(args)
    end

    def next_page?
      ensure_available
      @next_url_params.present?
    end

    def previous_page?
      ensure_available
      @previous_url_params.present?
    end

    def fetch_next_page
      fetch_page(@next_url_params)
    end

    def fetch_previous_page
      fetch_page(@previous_url_params)
    end

    private

    AVAILABLE_IN_VERSION = ShopifyAPI::ApiVersion::Release.new('2019-10')

    def fetch_page(url_params)
      ensure_available
      return [] unless url_params.present?

      resource_class.where(url_params)
    end

    def extract_url_params(link_header)
      return nil unless link_header.present?
      Rack::Utils.parse_nested_query(link_header.url.query)
    end

    def pagination_link_headers
      @pagination_link_headers ||= ShopifyAPI::PaginationLinkHeaders.new(
        ShopifyAPI::Base.connection.response["Link"]
      )
    end

    def ensure_available
      raise NotImplementedError unless ShopifyAPI::Base.api_version >= AVAILABLE_IN_VERSION
    end
  end
end
