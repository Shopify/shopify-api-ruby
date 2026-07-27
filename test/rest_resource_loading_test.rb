# typed: true
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class RestResourceLoadingTest < Minitest::Test
    BUNDLED_VERSION = "2026-04"
    UNBUNDLED_VERSION = "2026-10"

    def setup
      setup_context(api_version: BUNDLED_VERSION)
    end

    def teardown
      setup_context(api_version: BUNDLED_VERSION)
      ShopifyAPI::Context.deactivate_session
    end

    def test_rest_resources_are_loaded_for_a_bundled_version
      assert_operator(ShopifyAPI::Product, :<, ShopifyAPI::Rest::Base)
    end

    def test_explains_that_resources_are_not_bundled_for_the_active_version
      setup_context(api_version: UNBUNDLED_VERSION)

      error = assert_raises(ShopifyAPI::Errors::RestResourceNotLoadedError) do
        ShopifyAPI::Product
      end

      assert_kind_of(NameError, error)
      assert_includes(error.message, "uninitialized constant ShopifyAPI::Product")
      assert_includes(error.message, UNBUNDLED_VERSION)
      assert_includes(error.message, "GraphQL Admin API")
    end

    def test_names_the_latest_bundled_version_so_the_gap_is_obvious
      setup_context(api_version: UNBUNDLED_VERSION)

      error = assert_raises(ShopifyAPI::Errors::RestResourceNotLoadedError) do
        ShopifyAPI::Product
      end

      assert_includes(error.message, "latest bundled")
    end

    def test_explains_that_unstable_never_bundles_resources
      setup_context(api_version: "unstable")

      error = assert_raises(ShopifyAPI::Errors::RestResourceNotLoadedError) do
        ShopifyAPI::Product
      end

      assert_includes(error.message, "unstable")
    end

    def test_unknown_constants_still_raise_an_ordinary_name_error
      setup_context(api_version: UNBUNDLED_VERSION)

      error = assert_raises(NameError) do
        ShopifyAPI.const_missing(:NotAShopifyRestResource)
      end

      refute_kind_of(ShopifyAPI::Errors::RestResourceNotLoadedError, error)
    end

    def test_warns_when_the_resources_folder_is_missing
      # Context only warns once per version per process, so reset the record to
      # keep this test independent of execution order.
      ShopifyAPI::Context.instance_variable_set(:@notified_missing_resources_folder, {})
      setup_context(api_version: UNBUNDLED_VERSION)

      assert_includes(@logs.string, UNBUNDLED_VERSION)
      assert_includes(@logs.string, "REST resource")
      assert_includes(@logs.string, "GraphQL Admin API")
    end

    private

    def setup_context(api_version:)
      @logs = StringIO.new

      ShopifyAPI::Context.setup(
        api_key: "key",
        api_secret_key: "secret",
        api_version: api_version,
        scope: [],
        is_private: true,
        is_embedded: true,
        log_level: :warn,
        logger: Logger.new(@logs),
        private_shop: "privateshop.myshopify.com",
      )
    end
  end
end
