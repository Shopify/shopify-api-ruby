# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Rest
      class Admin
        extend T::Sig

        sig { params(session: Auth::Session).void }
        def initialize(session)
          @http_client = T.let(HttpClient.new(session: session, base_path: "/admin/api/#{Context.api_version}"),
            HttpClient)
        end

        sig do
          params(
            path: String,
            body: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            query: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: T.nilable(Integer)
          ).returns(HttpResponse)
        end
        def get(path:, body: nil, query: nil, headers: nil, tries: 1)
          request(http_method: :get, path: path, body: body, query: query, headers: headers, tries: T.must(tries))
        end

        sig do
          params(
            path: String,
            body: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            query: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: T.nilable(Integer)
          ).returns(HttpResponse)
        end
        def delete(path:, body: nil, query: nil, headers: nil, tries: 1)
          request(http_method: :delete, path: path, body: body, query: query, headers: headers, tries: T.must(tries))
        end

        sig do
          params(
            path: String,
            body: T::Hash[T.any(Symbol, String), T.untyped],
            query: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: T.nilable(Integer)
          ).returns(HttpResponse)
        end
        def put(path:, body:, query: nil, headers: nil, tries: 1)
          request(http_method: :put, path: path, body: body, query: query, headers: headers, tries: T.must(tries))
        end

        sig do
          params(
            path: String,
            body: T::Hash[T.any(Symbol, String), T.untyped],
            query: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: T.nilable(Integer)
          ).returns(HttpResponse)
        end
        def post(path:, body:, query: nil, headers: nil, tries: 1)
          request(http_method: :post, path: path, body: body, query: query, headers: headers, tries: T.must(tries))
        end

        private

        sig do
          params(
            http_method: Symbol,
            path: String,
            body: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            query: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer
          ).returns(HttpResponse)
        end
        def request(http_method:, path:, body:, query:, headers:, tries:)
          @http_client.request(HttpRequest.new(
            http_method: http_method,
            path: path,
            body: body,
            query: query,
            extra_headers: headers,
            body_type: body.nil? ? nil : "application/json",
            tries: tries
          ))
        end
      end
    end
  end
end
