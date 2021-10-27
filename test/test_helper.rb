# typed: false
# frozen_string_literal: true

require "minitest/autorun"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "shopify_api"

ShopifyAPI::Context.setup(api_key: "key", api_secret_key: "secret", host_name: "host",
  session_storage: ShopifyAPI::Auth::FileSessionStorage.new)
