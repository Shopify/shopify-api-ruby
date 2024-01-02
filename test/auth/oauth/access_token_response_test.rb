# typed: true
# frozen_string_literal: true

require_relative "../../test_helper"

module ShopifyAPITest
  module Auth
    module Oauth
      class AccessTokenResponseTest < Test::Unit::TestCase
        def test_online_token_is_false_when_no_associated_user
          token_response = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token: "token",
            scope: "scope1, scope2",
          )

          assert(!token_response.online_token?)
        end

        def test_online_token_is_true_when_associated_user_is_present
          associated_user = ShopifyAPI::Auth::AssociatedUser.new(
            id: 902541635,
            first_name: "first",
            last_name: "last",
            email: "firstlast@example.com",
            email_verified: true,
            account_owner: true,
            locale: "en",
            collaborator: false,
          )
          token_response = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token: "token",
            scope: "scope1, scope2",
            expires_in: 1000,
            associated_user_scope: "scope1",
            associated_user: associated_user,
          )

          assert(token_response.online_token?)
        end
      end
    end
  end
end
