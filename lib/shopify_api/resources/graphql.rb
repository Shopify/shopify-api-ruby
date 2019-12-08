# frozen_string_literal: true
require 'graphql/client'
require 'graphql/client/http'

module ShopifyAPI
  # GraphQL API.
  class GraphQL
    def initialize
      uri = Base.site.dup
      uri.path = Base.api_version.construct_graphql_path
      @http = ::GraphQL::Client::HTTP.new(uri.to_s) do
        define_method(:headers) do |_context|
          Base.headers
        end
      end
      @schema = ::GraphQL::Client.load_schema(@http)
      @client = ::GraphQL::Client.new(schema: @schema, execute: @http)
    end

    def self.schema
      @@schema ||= nil
    end

    # TODO: Support a temp file by default
    def self.dump_schema(filename, schema)
      return false unless filename and !File.exists?(filename)
      if filename.end_with?('.graphql')
        File.open(filename, 'w+'){ |io| io.puts(schema.to_definition) }
      else
        ::GraphQL::Client.dump_schema(schema, filename)
      end
    end

    # A local json/grahql file of the Shopify Schema
    def self.schema_file
      @@schema_file ||= nil
    end

    # Loads schema from +filename+ or fail silent. See tests for more.
    def self.schema_file=(filename)      
      @@schema_file = filename
      return nil unless File.exists?(filename)
      method = filename.end_with?('.graphql') ? ::GraphQL::Schema.method(:from_definition) : ::GraphQL::Client.method(:load_schema)
      @@schema = method.call(File.read(filename))
    end

    def self.session(shop, token, &block)
      # start Thread danger?
      session = ShopifyAPI::Session.new(domain: shop, token: token, api_version: '2019-10')
      ShopifyAPI::Base.activate_session(session)
      shop_headers = Base.headers.dup
      uri = Base.site.dup
      uri.path = Base.api_version.construct_graphql_path
      # end Thread danger?

      http = ::GraphQL::Client::HTTP.new(uri.to_s) do
        define_method(:headers) do |_context|
          shop_headers
        end
      end

      # start Thread danger?
      @@schema ||= nil
      if @@schema.nil?
        @@schema = ::GraphQL::Client.load_schema(http)
        dump_schema(schema_file, @@schema)
      end
      # end Thread danger?
      client = ::GraphQL::Client.new(schema: @@schema, execute: http)
      client.define_singleton_method(:http) { http }

      # TODO: Hit { shop { name } } to confirm
      if block_given?
        yield client
      else
        client
      end
    end

    delegate :parse, :query, to: :@client
  end
end
