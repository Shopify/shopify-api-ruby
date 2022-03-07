# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Asset202201Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2022-01")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Asset.all(
      session: @test_session,
      theme_id: 828155753,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "templates/index.liquid", "value" => "<img src='backsoon-postit.png'><p>We are busy updating the store for you and will be back within the hour.</p>"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    asset = ShopifyAPI::Asset.new(session: @test_session)
    asset.theme_id = 828155753
    asset.key = "templates/index.liquid"
    asset.value = "<img src='backsoon-postit.png'><p>We are busy updating the store for you and will be back within the hour.</p>"
    asset.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "assets/empty.gif", "attachment" => "R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==\n"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    asset = ShopifyAPI::Asset.new(session: @test_session)
    asset.theme_id = 828155753
    asset.key = "assets/empty.gif"
    asset.attachment = "R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==\n"
    asset.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "assets/bg-body.gif", "src" => "http://apple.com/new_bg.gif"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    asset = ShopifyAPI::Asset.new(session: @test_session)
    asset.theme_id = 828155753
    asset.key = "assets/bg-body.gif"
    asset.src = "http://apple.com/new_bg.gif"
    asset.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "layout/alternate.liquid", "source_key" => "layout/theme.liquid"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    asset = ShopifyAPI::Asset.new(session: @test_session)
    asset.theme_id = 828155753
    asset.key = "layout/alternate.liquid"
    asset.source_key = "layout/theme.liquid"
    asset.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json?asset%5Bkey%5D=templates%2Findex.liquid")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Asset.all(
      session: @test_session,
      theme_id: 828155753,
      asset: {"key" => "templates/index.liquid"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json?asset%5Bkey%5D=templates%2Findex.liquid")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json?asset%5Bkey%5D=assets%2Fbg-body.gif")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Asset.delete(
      session: @test_session,
      theme_id: 828155753,
      asset: {"key" => "assets/bg-body.gif"},
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/themes/828155753/assets.json?asset%5Bkey%5D=assets%2Fbg-body.gif")
  end

end
