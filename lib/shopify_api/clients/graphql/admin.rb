# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Admin < Client
        sig { params(session: T.nilable(Auth::Session)).void }
        def initialize(session)
          super(session: session, base_path: "/admin/api")
        end
      end
    end
  end
end
