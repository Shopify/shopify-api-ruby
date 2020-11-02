# frozen_string_literal: true
module ShopifyAPI
  class InvalidPaginationLinksError < StandardError; end

  class PaginationLinkHeaders
    LinkHeader = Struct.new(:url, :rel)
    attr_reader :previous_link, :next_link

    def initialize(link_header)
      links = parse_link_header(link_header)
      @previous_link = links.find { |link| link.rel == :previous }
      @next_link = links.find { |link| link.rel == :next }
    end

    private

    def parse_link_header(link_header)
      return [] unless link_header.present?
      links = link_header.split(',')
      links.map do |link|
        parts = link.split('; ')
        unless parts.length == 2
          raise ShopifyAPI::InvalidPaginationLinksError, "Invalid link header: url and rel expected"
        end

        url = parts[0][/<(.*)>/, 1]
        rel = parts[1][/rel="(.*)"/, 1]&.to_sym

        url = URI.parse(url).request_uri
        LinkHeader.new(url, rel)
      end
    end
  end
end
