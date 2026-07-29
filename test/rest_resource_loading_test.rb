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

    def test_preserves_name_error_name_for_consumers_that_inspect_it
      setup_context(api_version: UNBUNDLED_VERSION)

      error = assert_raises(ShopifyAPI::Errors::RestResourceNotLoadedError) do
        ShopifyAPI::Product
      end

      assert_equal(:Product, error.name)
    end

    def test_reports_the_missing_resource_in_a_process_that_only_requires_the_gem
      lib = File.expand_path("../lib", __dir__)
      output = IO.popen(
        [RbConfig.ruby, "-I#{lib}", "-e", 'require "shopify_api"; ShopifyAPI::Product'],
        err: [:child, :out],
        &:read
      )

      refute_includes(output, "uninitialized constant Logger")
      assert_includes(output, "RestResourceNotLoadedError")
      assert_includes(output, "Context has not been set up")
    end

    # Context builds a Logger at class-definition time, and the error message
    # above reads Context.api_version - so autoloading Context needs Logger to be
    # defined. Whether it happens to be defined transitively depends on the
    # resolved dependency set, which is why the entrypoint must require it. The
    # subprocess test above cannot catch a regression here on its own: under this
    # gem's own bundle, a locked dependency loads logger anyway.
    def test_entrypoint_requires_logger_rather_than_relying_on_a_transitive_require
      entrypoint = File.read(File.expand_path("../lib/shopify_api.rb", __dir__))

      assert_includes(entrypoint, %(require "logger"))
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
