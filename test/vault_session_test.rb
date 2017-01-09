require "test_helper"

class VaultSessionTest < Test::Unit::TestCase
  test "create vault session" do
    vault_url = "#{ShopifyAPI::VaultSession.site}#{ShopifyAPI::VaultSession.collection_path}"
    fake "vault_session", method: :post, status: 201, url: vault_url,
      body: load_fixture("vault_session")

    vault_session = ShopifyAPI::VaultSession.create(payment: { credit_card: { first_name: "Bob" } })
    assert_equal "east-da763221b43bb54fa3be535930a8d6d7", vault_session.id
  end
end
