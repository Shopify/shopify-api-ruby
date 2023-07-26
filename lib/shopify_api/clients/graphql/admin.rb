# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Admin < Client
        sig do
          params(
            session: T.nilable(Auth::Session),
            api_version: T.nilable(String),
            config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
          ).void
        end
        def initialize(session:, api_version: nil, config: ShopifyAPI::Context)
          super(session: session, base_path: "/admin/api", api_version: api_version, config: config)
        end
      end
    end
  end
end
