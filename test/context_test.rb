# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

class ContextTest < Minitest::Test
  def test_setup_properly_initializes_variables
    ShopifyAPI::Context.setup(
      api_key: "key",
      api_secret_key: "secret",
      host_name: "host",
      scope: ["scope1", "scope2"],
      is_private: true,
      session_storage: ShopifyAPI::Auth::FileSessionStorage.new
    )

    assert_equal(ShopifyAPI::Context.api_key, "key")
    assert_equal(ShopifyAPI::Context.api_secret_key, "secret")
    assert_equal(ShopifyAPI::Context.host_name, "host")
    assert_equal(["scope1", "scope2"], ShopifyAPI::Context.scope)
    assert(ShopifyAPI::Context.is_private)
    assert_equal(ShopifyAPI::Context.session_storage, ShopifyAPI::Auth::FileSessionStorage.new)
  end
end
