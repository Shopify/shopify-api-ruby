# typed: false

require_relative "../test_helper"

class ContextTest < Minitest::Test
  UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

  def test_create_session_with_id
    session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop")
    assert_equal(session.id, "id")
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
    assert(session.is_online)
  end
end
