# frozen_string_literal: true
require 'graphql/client'
require 'graphql/client/http'

module ShopifyAPI
  # GraphQL API.
  class GraphQL
    def initialize
      uri = Base.site.dup
      uri.path = '/admin/api/graphql.json'
      @http = ::GraphQL::Client::HTTP.new(uri.to_s) do
        define_method(:headers) do |_context|
          Base.headers
        end
      end
      @schema = ::GraphQL::Client.load_schema(@http)
      @client = ::GraphQL::Client.new(schema: @schema, execute: @http)
    end

    delegate :parse, :query, to: :@client
  end
end
