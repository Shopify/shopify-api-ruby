# typed: true
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class AdminVersionsTest < Minitest::Test
    def test_supported_admin_versions
      assert_instance_of(Array, ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS)
    end

    def test_unstable_is_first_and_dated_versions_are_newest_first
      versions = ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS

      assert_equal("unstable", versions.first)

      dated = versions.drop(1)
      assert_equal(dated.sort.reverse, dated, "dated versions must be listed newest first")
    end

    def test_includes_the_next_quarterly_release_candidate
      # The next quarterly is supported before its REST resources are bundled so
      # GraphQL and REST client users can target it on release day.
      assert_includes(ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS, "2026-10")
    end
  end
end
