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

    def self.reset
      @@schema = @@schema_file = nil
    end

    def self.dump_schema(filename, schema)
      return false unless filename and !File.exists?(filename)
      ::GraphQL::Client.dump_schema(schema, filename)
    end

    # Hopefully a local json file of the Shopify Schema
    def self.schema_file
      @@schema_file ||= nil
    end

    # Loads schema from +filename+ or fail silent. See tests for more.
    def self.schema_file=(filename)
      @@schema_file = filename
      @@schema = if File.exists?(filename)
        ::GraphQL::Client.load_schema(filename) rescue nil
      else 
        nil
      end
    end

    def self.session(shop, token, &block)
      session = ShopifyAPI::Session.new(domain: shop, token: token, api_version: '2019-10')
      ShopifyAPI::Base.activate_session(session)
      uri = Base.site.dup
      uri.path = Base.api_version.construct_graphql_path
      http = ::GraphQL::Client::HTTP.new(uri.to_s) do
        define_method(:headers) do |_context|
          Base.headers
        end
      end
      @@schema ||= nil
      if @@schema.nil?
          @@schema = ::GraphQL::Client.load_schema(http)
          dump_schema(schema_file, @@schema)
      end
      client = ::GraphQL::Client.new(schema: @@schema, execute: http)
      if block_given?
        yield client
      else
        client
      end
    end

    delegate :parse, :query, to: :@client
  end
end
