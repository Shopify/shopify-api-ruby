# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class GlobalApiToken < T::Struct
      const :access_token, String
      const :expires_at, Time
      const :scopes, T::Array[String]
    end
  end
end
