# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

class ContextTest < Minitest::Test
  def test_not_setup
    ShopifyAPI::Context.setup(
      api_key: "",
      api_secret_key: "",
      api_version: "",
      host_name: "",
      scope: [],
      is_private: false,
      is_embedded: true,
      session_storage: ShopifyAPI::Auth::FileSessionStorage.new
    )

    refute(ShopifyAPI::Context.setup?)
  end

  def test_setup
    ShopifyAPI::Context.setup(
      api_key: "key",
      api_secret_key: "secret",
      api_version: "version",
      host_name: "host",
      scope: ["scope1", "scope2"],
      is_private: true,
      is_embedded: true,
      session_storage: ShopifyAPI::Auth::FileSessionStorage.new
    )

    assert(ShopifyAPI::Context.setup?)
    assert_equal(ShopifyAPI::Context.api_key, "key")
    assert_equal(ShopifyAPI::Context.api_secret_key, "secret")
    assert_equal(ShopifyAPI::Context.api_version, "version")
    assert_equal(ShopifyAPI::Context.host_name, "host")
    assert_equal(ShopifyAPI::Auth::AuthScopes.new(["scope1", "scope2"]), ShopifyAPI::Context.scope)
    assert(ShopifyAPI::Context.private?)
    assert(ShopifyAPI::Context.private?)
    assert_equal(ShopifyAPI::Context.session_storage, ShopifyAPI::Auth::FileSessionStorage.new)
  end
end
