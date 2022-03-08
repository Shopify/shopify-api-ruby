# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Page202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Page.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json?since_id=108828309")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Page.all(
      since_id: "108828309",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json?since_id=108828309")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"title" => "Warranty information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.title = "Warranty information"
    page.body_html = "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"
    page.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"title" => "Warranty information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "published" => false}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.title = "Warranty information"
    page.body_html = "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"
    page.published = false
    page.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"title" => "Warranty information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "metafields" => [{"key" => "new", "value" => "new value", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.title = "Warranty information"
    page.body_html = "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"
    page.metafields = [
      {
        "key" => "new",
        "value" => "new value",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    page.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/pages.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Page.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages/count.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Page.find(
      id: 131092082,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"id" => 131092082, "body_html" => "<p>Returns accepted if we receive the items 14 days after purchase.</p>"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.body_html = "<p>Returns accepted if we receive the items 14 days after purchase.</p>"
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"id" => 131092082, "body_html" => "<p>Returns accepted if we receive the items <strong>14 days</strong> after purchase.</p>", "author" => "Christopher Gorski", "title" => "New warranty", "handle" => "new-warranty"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.body_html = "<p>Returns accepted if we receive the items <strong>14 days</strong> after purchase.</p>"
    page.author = "Christopher Gorski"
    page.title = "New warranty"
    page.handle = "new-warranty"
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"id" => 131092082, "published" => true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.published = true
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"id" => 131092082, "published" => false}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.published = false
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"id" => 131092082, "metafields" => [{"key" => "new", "value" => "new value", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.metafields = [
      {
        "key" => "new",
        "value" => "new value",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Page.delete(
      id: 131092082,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/pages/131092082.json")
  end

end
