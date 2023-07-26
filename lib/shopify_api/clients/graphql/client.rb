# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Client
        extend T::Sig

        sig do
          params(
            session: T.nilable(Auth::Session),
            base_path: String,
            api_version: T.nilable(String),
            config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
          ).void
        end
        def initialize(session:, base_path:, api_version: nil, config: ShopifyAPI::Context)
          @http_client = T.let(HttpClient.new(session: session, base_path: base_path, config: config), HttpClient)
          @api_version = T.let(api_version || config.api_version, String)
          if api_version
            if api_version == config.api_version
              config.logger.debug("Graphql client has a redundant API version override "\
                "to the default #{config.api_version}")
            else
              config.logger.debug("Graphql client overriding default API version "\
                "#{config.api_version} with #{api_version}")
            end
          end
        end

        sig do
          params(
            query: String,
            variables: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer,
          ).returns(HttpResponse)
        end
        def query(query:, variables: nil, headers: nil, tries: 1)
          body = { query: query, variables: variables }
          @http_client.request(
            HttpRequest.new(
              http_method: :post,
              path: "#{@api_version}/graphql.json",
              body: body,
              query: nil,
              extra_headers: headers,
              body_type: "application/json",
              tries: tries,
            ),
          )
        end
      end
    end
  end
end
