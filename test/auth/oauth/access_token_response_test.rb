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

        def test_equality_with_all_fields_matching
          access_token = "access_token"
          scope = "scope1, scope2"
          session = "session_id"
          expires_in = 3600
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
          associated_user_scope = "user_scope"
          refresh_token = "refresh_token_value"
          refresh_token_expires_in = 2000

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            session:,
            expires_in:,
            associated_user:,
            associated_user_scope:,
            refresh_token:,
            refresh_token_expires_in:,
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            session:,
            expires_in:,
            associated_user:,
            associated_user_scope:,
            refresh_token:,
            refresh_token_expires_in:,
          )

          assert_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_access_token
          scope = "scope1, scope2"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token: "access_token_1",
            scope:,
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token: "access_token_2",
            scope:,
          )

          refute_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_scope
          access_token = "access_token"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope: "scope1, scope2",
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope: "scope3, scope4",
          )

          refute_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_session
          access_token = "access_token"
          scope = "scope1, scope2"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            session: "session_1",
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            session: "session_2",
          )

          refute_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_expires_in
          access_token = "access_token"
          scope = "scope1, scope2"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            expires_in: 3600,
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            expires_in: 7200,
          )

          refute_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_associated_user
          access_token = "access_token"
          scope = "scope1, scope2"
          associated_user1 = ShopifyAPI::Auth::AssociatedUser.new(
            id: 1,
            first_name: "first",
            last_name: "last",
            email: "firstlast@example.com",
            email_verified: true,
            account_owner: true,
            locale: "en",
            collaborator: false,
          )
          associated_user2 = ShopifyAPI::Auth::AssociatedUser.new(
            id: 2,
            first_name: "other",
            last_name: "user",
            email: "otheruser@example.com",
            email_verified: true,
            account_owner: false,
            locale: "en",
            collaborator: true,
          )

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            associated_user: associated_user1,
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            associated_user: associated_user2,
          )

          refute_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_associated_user_scope
          access_token = "access_token"
          scope = "scope1, scope2"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            associated_user_scope: "user_scope_1",
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            associated_user_scope: "user_scope_2",
          )

          refute_equal(token_response1, token_response2)
        end

        def test_refresh_token_can_be_set
          token_response = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token: "token",
            scope: "scope1, scope2",
            expires_in: 1000,
            refresh_token: "refresh_token_value",
            refresh_token_expires_in: 2000,
          )

          assert_equal("refresh_token_value", token_response.refresh_token)
          assert_equal(2000, token_response.refresh_token_expires_in)
        end

        def test_inequality_with_different_refresh_token
          access_token = "access_token"
          scope = "scope1, scope2"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(access_token:, scope:,
            refresh_token: "refresh_token_1")
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(access_token:, scope:,
            refresh_token: "refresh_token_2")

          refute_equal(token_response1, token_response2)
        end

        def test_inequality_with_different_refresh_token_expires_in
          access_token = "access_token"
          scope = "scope1, scope2"

          token_response1 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            refresh_token_expires_in: 123,
          )
          token_response2 = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
            access_token:,
            scope:,
            refresh_token_expires_in: 321,
          )

          refute_equal(token_response1, token_response2)
        end
      end
    end
  end
end
