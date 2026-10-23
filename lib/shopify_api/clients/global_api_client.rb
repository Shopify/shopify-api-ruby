# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    class GlobalApiClient < HttpClient
      extend T::Sig

      sig { params(base_path: String, access_token: T.nilable(String)).void }
      def initialize(base_path:, access_token: nil)
        super(base_path: base_path, base_uri: Context.global_api_url, access_token: access_token)
      end
    end
  end
end
