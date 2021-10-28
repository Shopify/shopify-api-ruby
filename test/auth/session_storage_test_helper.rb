# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module SessionStorageTestHelper
  def session
    associated_user = ShopifyAPI::Auth::AssociatedUser.new(
      id: 123,
      first_name: "first-name",
      last_name: "last-name",
      email: "user@test.com",
      email_verified: true,
      account_owner: true,
      locale: "en-us",
      collaborator: true
    )
    ShopifyAPI::Auth::Session.new(
      id: "id",
      shop: "test-shop",
      state: "test-state",
      access_token: "test-access-token",
      scope: ["test-scope"],
      expires: 12345,
      is_online: true,
      associated_user: associated_user
    )
  end

  def test_store_session
    assert(@storage.store_session(session))
  end

  def test_load_session
    @storage.store_session(session)
    loaded_session = @storage.load_session(session.id)
    assert_equal(session, loaded_session)
  end

  def test_delete_session
    @storage.store_session(session)
    assert(@storage.delete_session(session.id))
    assert_nil(@storage.load_session(session.id))
  end
end
