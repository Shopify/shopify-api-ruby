# typed: false
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class FirstPartyDevelopmentTest < Test::Unit::TestCase
    include TestHelpers::FirstPartyDevelopment

    SHOP_HOSTS = ["shop1.my.shop.dev", "shop1.my.shop.devns.shop"].freeze

    def test_validates_local_shops_using_the_shared_helper_without_a_liveness_check
      core = mock("Core")
      with_dev_server(core) do
        SHOP_HOSTS.each do |shop|
          core.expects(:shop_domain?).with(shop).returns(true)
          assert_equal(shop, ShopifyAPI::Utils::ShopValidator.sanitize!("https://#{shop}/"))
        end
      end
    end

    def test_rejects_devns_shops_outside_dev_even_if_dev_server_is_loaded
      with_dev_server(mock("Core"), enabled: false) do
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("shop1.my.shop.devns.shop")
        end
      end
    end

    def test_rejects_devns_shops_without_dev_server
      assert_raises(ShopifyAPI::Errors::InvalidShopError) do
        ShopifyAPI::Utils::ShopValidator.sanitize!("shop1.my.shop.devns.shop")
      end
    end

    def test_the_shared_helper_can_reject_a_development_host
      shop = "shop1.my.shop.devns.shop"
      core = mock("Core")
      core.expects(:shop_domain?).with(shop).returns(false)
      with_dev_server(core) do
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!(shop)
        end
      end
    end

    def test_validates_both_conventions_with_older_dev_server
      with_dev_server(mock("Older Core")) do
        SHOP_HOSTS.each do |shop|
          assert_equal(shop, ShopifyAPI::Utils::ShopValidator.sanitize!(shop))
        end
        [
          "devns.shop", "app.shop.devns.shop", "my.shop.devns.shop",
          "shop1.my.shop.dev.example.com", "shop1.my.shop.devns.shop.example.com",
        ].each do |shop|
          assert_raises(ShopifyAPI::Errors::InvalidShopError) do
            ShopifyAPI::Utils::ShopValidator.sanitize!(shop)
          end
        end
      end
    end

    def test_requests_use_shared_shop_rewrite_and_preserve_the_shop_and_access_token
      SHOP_HOSTS.each do |shop|
        core = mock("Core")
        core.stubs(:shop_domain?).with(shop).returns(true)
        core.expects(:shop_request).with("https://#{shop}/admin/api/test.json", anything).returns(
          Struct.new(:url, :headers).new("https://app.shop.devns.shop/admin/api/test.json", {
            "X-Forwarded-Host" => shop,
            "X-Shopify-Access-Token" => "test-token",
          }),
        )
        with_dev_server(core) do
          assert_local_request(shop, target: shop, core_host: "app.shop.devns.shop")
        end
      end
    end

    def test_requests_keep_an_explicit_api_host_with_shared_helpers
      shop = "shop1.my.shop.devns.shop"
      core = mock("Core")
      core.stubs(:shop_domain?).with(shop).returns(true)
      core.expects(:shop_request).with("https://#{shop}/admin/api/test.json", has_entry("Host", shop)).returns(
        Struct.new(:url, :headers).new("https://app.shop.devns.shop/admin/api/test.json", {
          "X-Forwarded-Host" => shop,
          "X-Shopify-Access-Token" => "test-token",
        }),
      )
      with_dev_server(core) do
        modify_context(api_host: "api.example.com")
        assert_local_request(shop, target: "api.example.com", core_host: "app.shop.devns.shop")
      end
    end

    def test_requests_with_older_dev_server_keep_working_for_both_conventions
      SHOP_HOSTS.each do |shop|
        core = mock("Older Core")
        core.expects(:host!).with(:app).returns("app.shop.dev")
        with_dev_server(core) do
          assert_local_request(shop, target: shop, core_host: "app.shop.dev")
        end
      end
    end

    def test_already_forwarded_requests_are_preserved_with_either_header_casing
      ["x-forwarded-host", "X-Forwarded-Host"].each do |header|
        shop = "shop1.my.shop.devns.shop"
        forwarded_shop = "shop2.my.shop.devns.shop"
        core = mock("Core")
        core.stubs(:shop_domain?).with(shop).returns(true)
        core.stubs(:shop_domain?).with(forwarded_shop).returns(true)
        with_dev_server(core) do
          stub_request(:get, "https://#{shop}/admin/api/test.json")
            .with(headers: { header => forwarded_shop }).to_return(body: "{}")
          client_for(shop).request(request(extra_headers: { header => forwarded_shop }))
        end
      end
    end

    def test_oauth_uses_the_shared_admin_url_for_both_conventions
      SHOP_HOSTS.each do |shop|
        core = mock("Core")
        core.stubs(:shop_domain?).with(shop).returns(true)
        core.expects(:admin_url).with(shop).returns("https://admin.shop.devns.shop/store/shop1")
        with_dev_server(core) { assert_oauth_route(shop, "admin.shop.devns.shop", "/store/shop1/oauth/authorize") }
      end
    end

    def test_oauth_with_older_dev_server_keeps_working_for_both_conventions
      SHOP_HOSTS.each do |shop|
        with_dev_server(mock("Older Core")) do |dev_server|
          admin = mock("admin-web")
          dev_server.expects(:new).with("admin-web").returns(admin)
          admin.expects(:host!).with(nonstandard_host_prefix: "admin").returns("admin.shop.dev")
          assert_oauth_route(shop, "admin.shop.dev", "/store/shop1/oauth/authorize")
        end
      end
    end

    def test_production_and_lookalike_hosts_are_not_rewritten
      ["shop1.myshopify.com", "shop1.my.shop.dev.example.com", "shop1.my.shop.devns.shop.example.com"].each do |shop|
        with_dev_server(mock("Older Core")) do
          stub_request(:get, "https://#{shop}/admin/api/test.json")
            .with { |req| !req.headers.key?("X-Forwarded-Host") }.to_return(body: "{}")
          client_for(shop).request(request)
          assert_oauth_route(shop, shop, "/admin/oauth/authorize")
        end
      end
    end

    private

    def client_for(shop)
      session = ShopifyAPI::Auth::Session.new(shop: shop, access_token: "test-token")
      ShopifyAPI::Clients::HttpClient.new(session: session, base_path: "/admin/api")
    end

    def request(extra_headers: nil)
      ShopifyAPI::Clients::HttpRequest.new(http_method: :get, path: "test.json", extra_headers: extra_headers)
    end

    def assert_local_request(shop, target:, core_host:)
      expected = stub_request(:get, "https://#{target}/admin/api/test.json").with(headers: {
        "Host" => core_host,
        "X-Forwarded-Host" => shop,
        "X-Shopify-Access-Token" => "test-token",
      }).to_return(body: "{}")
      client_for(shop).request(request)
      assert_requested(expected)
    end

    def assert_oauth_route(shop, host, path)
      result = ShopifyAPI::Auth::Oauth.begin_auth(shop: shop, redirect_path: "/callback")
      uri = URI(result[:auth_route])
      assert_equal(host, uri.host)
      assert_equal(path, uri.path)
      assert_equal("https://app-address.com/callback", CGI.parse(uri.query).fetch("redirect_uri").first)
    end
  end
end
