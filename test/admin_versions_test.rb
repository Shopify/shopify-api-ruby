# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class AdminVersionsTest < Minitest::Test
    def test_supported_admin_versions
      assert_instance_of(Array, ShopifyAPI::SUPPORTED_ADMIN_VERSIONS)
    end

    def test_supported_latest_supported_admin_version
      assert_instance_of(String, ShopifyAPI::LATEST_SUPPORTED_ADMIN_VERSION)
    end
    
    def test_loading_of_shopify_admin_versions
      assert_instance_of(Class, ShopifyAPI::AdminVersions)
    end
  end
end
