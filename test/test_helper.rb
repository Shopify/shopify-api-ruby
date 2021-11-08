# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "shopify_api"

Dir[File.dirname(__FILE__) + "/test_helpers/*.rb"].each { |file| require file }

API_KEY = "API_KEY"
API_SECRET_KEY = "API_SECRET_KEY"
HOST_NAME = "app-address.com"
SCOPE = T.let(["scope1", "scope2"], T::Array[String])

module Test
  module Unit
    class TestCase < Minitest::Test
      extend T::Sig

      sig { void }
      def setup
        ShopifyAPI::Context.setup(
          api_key: API_KEY,
          api_secret_key: API_SECRET_KEY,
          host_name: HOST_NAME,
          scope: SCOPE,
          is_private: false,
          session_storage: TestHelpers::FakeSessionStorage.new(sessions: {}, error_on_save: false)
        )
      end
    end
  end
end
