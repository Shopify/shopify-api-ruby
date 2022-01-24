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
        session1 = ShopifyAPI::Auth::Session.new(id: "id1", shop: "test-shop")
        session2 = ShopifyAPI::Auth::Session.new(id: "id2", shop: "test-shop")

        ShopifyAPI::Context.activate_session(session1)

        session2.temp { assert_equal(session2, ShopifyAPI::Context.active_session) }
        assert_equal(session1, ShopifyAPI::Context.active_session)
      end

      def teardown
        ShopifyAPI::Context.deactivate_session
      end
    end
  end
end
