# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Client
        extend T::Sig

        sig { params(session: T.nilable(Auth::Session), base_path: String, api_version: T.nilable(String)).void }
        def initialize(session:, base_path:, api_version: nil)
          @http_client = T.let(HttpClient.new(session: session, base_path: base_path), HttpClient)
          @api_version = T.let(api_version || Context.api_version, String)
          if api_version
            if api_version == Context.api_version
              Context.logger.debug("Graphql client has a redundant API version override "\
                "to the default #{Context.api_version}")
            else
              Context.logger.debug("Graphql client overriding default API version "\
                "#{Context.api_version} with #{api_version}")
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
            response_as_struct: Context.response_as_struct || false,
          )
        end
      end
    end
  end
end
