# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Client
        extend T::Sig

        sig { params(session: T.nilable(Auth::Session), base_path: String).void }
        def initialize(session:, base_path:)
          @http_client = T.let(HttpClient.new(session: session, base_path: base_path), HttpClient)
        end

        sig do
          params(
            query: String,
            variables: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer,
            api_version: T.nilable(String),
          ).returns(HttpResponse)
        end
        def query(query:, variables: nil, headers: nil, tries: 1, api_version: nil)
          body = { query: query, variables: variables }
          api_version ||= Context.api_version
          @http_client.request(
            HttpRequest.new(
              http_method: :post,
              path: "#{api_version}/graphql.json",
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
