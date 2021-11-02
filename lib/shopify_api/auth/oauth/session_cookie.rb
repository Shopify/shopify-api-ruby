# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module Oauth
      class SessionCookie < T::Struct
        const :name, String, default: "shopify_app_session"
        const :value, String
        const :expires, Time
      end
    end
  end
end
