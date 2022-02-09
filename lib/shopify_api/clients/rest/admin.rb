# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Rest
      class Admin < HttpClient
        extend T::Sig

        sig { params(session: T.nilable(Auth::Session)).void }
        def initialize(session: nil)
          super(session: session, base_path: "/admin/api/#{Context.api_version}")
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
          request(
            make_request(http_method: :get, path: path, body: body, query: query, headers: headers,
              tries: T.must(tries))
          )
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
          request(
            make_request(http_method: :delete, path: path, body: body, query: query, headers: headers,
              tries: T.must(tries))
          )
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
          request(
            make_request(http_method: :put, path: path, body: body, query: query, headers: headers,
              tries: T.must(tries))
          )
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
          request(
            make_request(http_method: :post, path: path, body: body, query: query, headers: headers,
              tries: T.must(tries))
          )
        end

        protected

        sig { params(request: HttpRequest).returns(String) }
        def request_url(request)
          if request.path.start_with?("/admin")
            "#{@base_uri}#{request.path}"
          else
            "#{@base_uri_and_path}/#{request.path}"
          end
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
          ).returns(HttpRequest)
        end
        def make_request(http_method:, path:, body:, query:, headers:, tries:)
          HttpRequest.new(
            http_method: http_method,
            path: path,
            body: body,
            query: query,
            extra_headers: headers,
            body_type: body.nil? ? nil : "application/json",
            tries: tries
          )
        end
      end
    end
  end
end
