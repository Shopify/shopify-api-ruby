# frozen_string_literal: true
require 'graphql/client'
require 'graphql/client/http'

module ShopifyAPI
  # GraphQL API.
  class GraphQL
    class_attribute :graphql_client

    def initialize(schema = nil)
      uri = Base.site.dup
      uri.path = '/admin/api/graphql.json'

      @http_client = ::GraphQL::Client::HTTP.new(uri.to_s) do
        define_method(:headers) do |_context|
          Base.headers
        end
      end

      unless graphql_client
        schema ||= @http_client
        schema = ::GraphQL::Client.load_schema(schema)
        self.class.graphql_client = ::GraphQL::Client.new(schema: schema, execute: @http_client)
      end

      client.instance_variable_set(:@execute, @http_client)
    end

    delegate :parse, :query, to: :graphql_client
  end
end
