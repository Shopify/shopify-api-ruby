# typed: true
# frozen_string_literal: true

module ShopifyAPITest
  module Auth
    module Oauth
      class AuthQueryTest < Minitest::Test
        def test_auth_query_is_alphabetical
          query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
            code: "somecode",
            shop: "some-shop.myshopify.com",
            state: "1234",
            timestamp: "123456",
            host: "host",
            hmac: "hmac"
          )

          alphabetical_encoded_string = URI.encode_www_form({
            code: "somecode",
            host: "host",
            shop: "some-shop.myshopify.com",
            state: "1234",
            timestamp: "123456",
          })

          assert_equal(alphabetical_encoded_string, query.to_signable_string)
        end
      end
    end
  end
end
