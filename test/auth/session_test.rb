# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class SessionTest < Test::Unit::TestCase
      UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

      def test_create_session_with_id
        session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop")
        assert_equal("id", session.id)
      end

      def test_create_session_no_id
        session = ShopifyAPI::Auth::Session.new(shop: "test-shop")
        assert(UUID_REGEX.match?(session.id))
      end

      def test_is_online_with_associated_user
        user = ShopifyAPI::Auth::AssociatedUser.new(
          id: 1,
          first_name: "first name",
          last_name: "last name",
          email: "my.email@email.com",
          email_verified: true,
          account_owner: true,
          locale: "en",
          collaborator: true,
        )

        session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop", associated_user: user)
        assert(session.online?)
      end

      def test_expired_with_no_expiry_date
        session = ShopifyAPI::Auth::Session.new(shop: "test-shop")

        assert_equal(false, session.expired?)
      end

      def test_expired_with_future_expiry_date
        session = ShopifyAPI::Auth::Session.new(shop: "test-shop", expires: Time.now + 1 * 60 * 60)

        assert_equal(false, session.expired?)
      end

      def test_expired_with_passed_expiry_date
        session = ShopifyAPI::Auth::Session.new(shop: "test-shop", expires: Time.now - 1)

        assert(session.expired?)
      end

      def test_temp
        session = ShopifyAPI::Auth::Session.new(shop: "test-shop1", access_token: "token1")

        ShopifyAPI::Context.activate_session(session)

        ShopifyAPI::Auth::Session.temp(shop: "test_shop2", access_token: "token2") do
          assert_equal("test_shop2", ShopifyAPI::Context.active_session.shop)
          assert_equal("token2", ShopifyAPI::Context.active_session.access_token)
        end

        assert_equal(session, ShopifyAPI::Context.active_session)
      end

      def test_temp_with_block_var
        session = ShopifyAPI::Auth::Session.new(shop: "test-shop1", access_token: "token1")

        ShopifyAPI::Context.activate_session(session)

        ShopifyAPI::Auth::Session.temp(shop: "test_shop2", access_token: "token2") do |temp_session|
          assert_equal("test_shop2", temp_session.shop)
          assert_equal("token2", temp_session.access_token)
          assert_equal(temp_session, ShopifyAPI::Context.active_session)
        end

        assert_equal(session, ShopifyAPI::Context.active_session)
      end

      def test_from_with_offline_access_token_response
        shop = "test-shop"
        response = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
          access_token: "token",
          scope: "scope1, scope2",
          session: "session",
        )
        expected_session = ShopifyAPI::Auth::Session.new(
          id: "offline_#{shop}",
          shop: shop,
          access_token: response.access_token,
          scope: response.scope,
          is_online: false,
          associated_user_scope: nil,
          associated_user: nil,
          expires: nil,
          shopify_session_id: response.session,
        )

        session = ShopifyAPI::Auth::Session.from(shop: shop, access_token_response: response)

        assert_equal(expected_session, session)
      end

      def test_from_with_online_access_token_response
        shop = "test-shop"
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
        response = ShopifyAPI::Auth::Oauth::AccessTokenResponse.new(
          access_token: "token",
          scope: "scope1, scope2",
          session: "session",
          expires_in: 1000,
          associated_user: associated_user,
          associated_user_scope: "scope1",
        )
        time_now = Time.now
        expected_session = ShopifyAPI::Auth::Session.new(
          id: "#{shop}_#{associated_user.id}",
          shop: shop,
          access_token: response.access_token,
          scope: response.scope,
          is_online: false,
          associated_user_scope: response.associated_user_scope,
          associated_user: associated_user,
          expires: time_now + response.expires_in,
          shopify_session_id: response.session,
        )

        session = Time.stub(:now, time_now) do
          ShopifyAPI::Auth::Session.from(shop: shop, access_token_response: response)
        end

        assert_equal(expected_session, session)
      end

      def test_copy_attributes_from
        session_to = ShopifyAPI::Auth::Session.new(
          id: "session-id",
          shop: "shop",
          state: "some-state",
          access_token: "to-token",
          scope: "read_products,read_themes",
          associated_user_scope: "read_products",
          expires: Time.now - 3600,
          associated_user: build_user,
          is_online: true,
          shopify_session_id: "123",
        )

        session_from = ShopifyAPI::Auth::Session.new(
          id: "session-id",
          shop: "shop",
          state: nil,
          access_token: "from-token",
          scope: "write_products,read_themes",
          associated_user_scope: "write_products",
          expires: Time.now + 24 * 3600,
          associated_user: build_user,
          is_online: true,
          shopify_session_id: "456",
        )

        assert_equal(session_to, session_to.copy_attributes_from(session_from))

        assert_equal(session_from.shop, session_to.shop)
        assert_nil(session_to.state)
        assert_equal(session_from.access_token, session_to.access_token)
        assert_equal(session_from.scope, session_to.scope)
        assert_equal(session_from.associated_user_scope, session_to.associated_user_scope)
        assert_equal(session_from.expires, session_to.expires)
        assert_equal(session_from.associated_user, session_to.associated_user)
        assert_equal(session_from.shopify_session_id, session_to.shopify_session_id)
      end

      def teardown
        ShopifyAPI::Context.deactivate_session
      end

      private

      def build_user
        ShopifyAPI::Auth::AssociatedUser.new(
          id: 1,
          first_name: "Hello #{Time.now}",
          last_name: "World",
          email: "Email",
          email_verified: true,
          account_owner: true,
          locale: "en",
          collaborator: false,
        )
      end
    end
  end
end
