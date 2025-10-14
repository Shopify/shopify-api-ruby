# typed: true
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class AdminVersionsTest < Minitest::Test
    def test_supported_admin_versions
      assert_instance_of(Array, ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS)
    end
  end
end
