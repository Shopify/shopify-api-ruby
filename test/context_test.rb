# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

class ContextTest < Minitest::Test
  def test_setup_properly_initializes_variables
    ShopifyAPI::Context.setup(
      api_key: "key",
      api_secret_key: "secret",
      host_name: "host",
      session_storage: ShopifyAPI::Auth::FileSessionStorage.new
    )

    assert_equal("key", ShopifyAPI::Context.api_key)
    assert_equal("secret", ShopifyAPI::Context.api_secret_key)
    assert_equal("host", ShopifyAPI::Context.host_name)
    assert_equal(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Context.session_storage)
  end
end
