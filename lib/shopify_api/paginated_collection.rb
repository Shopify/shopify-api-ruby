# frozen_string_literal: true

module ShopifyAPI
  class PaginatedCollection < ActiveResource::Collection
    module CollectionPagination
      def initialize(args)
        @next_url = pagination_link_headers.next_link&.url&.to_s
        @previous_url = pagination_link_headers.previous_link&.url&.to_s
        super(args)
      end

      def next_page?
        ensure_available
        @next_url.present?
      end

      def previous_page?
        ensure_available
        @previous_url.present?
      end

      def fetch_next_page
        fetch_page(@next_url)
      end

      def fetch_previous_page
        fetch_page(@previous_url)
      end

      def next_page_info
        extract_page_info(@next_url)
      end

      def previous_page_info
        extract_page_info(@previous_url)
      end

      private

      AVAILABLE_IN_VERSION = ShopifyAPI::ApiVersion.find_version('2019-10')
      AVAILABLE_IN_VERSION_EARLY = ShopifyAPI::ApiVersion.find_version('2019-07')

      def fetch_page(url)
        ensure_available
        return [] unless url.present?

        resource_class.all(from: url)
      end

      def pagination_link_headers
        @pagination_link_headers ||= ShopifyAPI::PaginationLinkHeaders.new(
          ShopifyAPI::Base.connection.response["Link"]
        )
      end

      def ensure_available
        return if ShopifyAPI::Base.api_version >= AVAILABLE_IN_VERSION
        return if ShopifyAPI::Base.api_version >= AVAILABLE_IN_VERSION_EARLY && resource_class.early_july_pagination?
        raise NotImplementedError
      end

      def extract_page_info(url)
        CGI.escape(Rack::Utils.parse_query(URI(url).query)['page_info']) if url.present?
      end
    end

    include CollectionPagination
  end
end
