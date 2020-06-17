# frozen_string_literal: true
require 'graphql/client/http'

module ShopifyAPI
  module GraphQL
    class HTTPClient < ::GraphQL::Client::HTTP
      def initialize(api_version)
        @api_version = api_version
      end

      def headers(_context)
        ShopifyAPI::Base.headers
      end

      def uri
        ShopifyAPI::Base.site.dup.tap do |uri|
          uri.path = "/admin/api/#{@api_version}/graphql.json"
        end
      end
    end
  end
end