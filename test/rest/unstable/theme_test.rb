# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ThemeUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/themes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Theme.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/themes.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/themes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "theme" => hash_including({name: "Lemongrass", src: "http://themes.shopify.com/theme.zip", role: "main"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    theme = ShopifyAPI::Theme.new(session: @test_session)
    theme.name = "Lemongrass"
    theme.src = "http://themes.shopify.com/theme.zip"
    theme.role = "main"
    theme.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/themes.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/themes/828155753.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Theme.find(
      session: @test_session,
      id: 828155753,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/themes/828155753.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/themes/752253240.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "theme" => hash_including({id: 752253240, name: "Experimental"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    theme = ShopifyAPI::Theme.new(session: @test_session)
    theme.id = 752253240
    theme.name = "Experimental"
    theme.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/themes/752253240.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/themes/752253240.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "theme" => hash_including({id: 752253240, role: "main"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    theme = ShopifyAPI::Theme.new(session: @test_session)
    theme.id = 752253240
    theme.role = "main"
    theme.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/themes/752253240.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/unstable/themes/752253240.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Theme.delete(
      session: @test_session,
      id: 752253240,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/unstable/themes/752253240.json")
  end

end
