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
          collaborator: true
        )

        session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop", associated_user: user)
        assert(session.online?)
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

      def teardown
        ShopifyAPI::Context.deactivate_session
      end
    end
  end
end
