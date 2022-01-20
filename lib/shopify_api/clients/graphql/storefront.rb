# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Storefront < Client
        sig { params(shop: String, storefront_access_token: String).void }
        def initialize(shop, storefront_access_token)
          session = Auth::Session.new(
            id: shop,
            shop: shop,
            access_token: "",
            is_online: false
          )
          super(session: session, base_path: "/api")
          @storefront_access_token = storefront_access_token
        end

        sig do
          params(
            query: String,
            variables: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer
          ).returns(HttpResponse)
        end
        def query(query:, variables: nil, headers: {}, tries: 1)
          T.must(headers).merge!({ "X-Shopify-Storefront-Access-Token": @storefront_access_token })
          super(query: query, variables: variables, headers: headers, tries: tries)
        end
      end
    end
  end
end
