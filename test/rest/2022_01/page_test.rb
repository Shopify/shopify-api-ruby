# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Page202201Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"pages" => [{"id" => 108828309, "title" => "Sample Page", "shop_id" => 548380009, "handle" => "sample", "body_html" => "<p>this is a <strong>sample</strong> page.</p>", "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2008-07-16T20:00:00-04:00", "published_at" => nil, "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/108828309"}, {"id" => 169524623, "title" => "Store hours", "shop_id" => 548380009, "handle" => "store-hours", "body_html" => "<p>We never close.</p>", "author" => "Jobs", "created_at" => "2013-12-31T19:00:00-05:00", "updated_at" => "2013-12-31T19:00:00-05:00", "published_at" => "2014-02-01T19:00:00-05:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/169524623"}, {"id" => 322471, "title" => "Support", "shop_id" => 548380009, "handle" => "support", "body_html" => "<p>Come in store for support.</p>", "author" => "Dennis", "created_at" => "2009-07-15T20:00:00-04:00", "updated_at" => "2009-07-16T20:00:00-04:00", "published_at" => nil, "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/322471"}, {"id" => 131092082, "title" => "Terms of Services", "shop_id" => 548380009, "handle" => "tos", "body_html" => "<p>We make <strong>perfect</strong> stuff, we don't need a warranty.</p>", "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2008-07-16T20:00:00-04:00", "published_at" => "2008-07-15T20:00:00-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}]}), headers: {})

    ShopifyAPI::Page.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json?since_id=108828309")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"pages" => [{"id" => 131092082, "title" => "Terms of Services", "shop_id" => 548380009, "handle" => "tos", "body_html" => "<p>We make <strong>perfect</strong> stuff, we don't need a warranty.</p>", "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2008-07-16T20:00:00-04:00", "published_at" => "2008-07-15T20:00:00-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}, {"id" => 169524623, "title" => "Store hours", "shop_id" => 548380009, "handle" => "store-hours", "body_html" => "<p>We never close.</p>", "author" => "Jobs", "created_at" => "2013-12-31T19:00:00-05:00", "updated_at" => "2013-12-31T19:00:00-05:00", "published_at" => "2014-02-01T19:00:00-05:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/169524623"}]}), headers: {})

    ShopifyAPI::Page.all(
      since_id: "108828309",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json?since_id=108828309")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"title" => "Warranty information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"id" => 1025371371, "title" => "Warranty information", "shop_id" => 548380009, "handle" => "warranty-information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "author" => "Shopify API", "created_at" => "2022-04-05T13:25:18-04:00", "updated_at" => "2022-04-05T13:25:18-04:00", "published_at" => "2022-04-05T13:25:18-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/1025371371"}}), headers: {})

    page = ShopifyAPI::Page.new
    page.title = "Warranty information"
    page.body_html = "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"
    page.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"title" => "Warranty information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"id" => 1025371372, "title" => "Warranty information", "shop_id" => 548380009, "handle" => "warranty-information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "author" => "Shopify API", "created_at" => "2022-04-05T13:25:20-04:00", "updated_at" => "2022-04-05T13:25:20-04:00", "published_at" => nil, "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/1025371372"}}), headers: {})

    page = ShopifyAPI::Page.new
    page.title = "Warranty information"
    page.body_html = "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>"
    page.published = false
    page.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"title" => "Warranty information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "metafields" => [{"key" => "new", "value" => "new value", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"id" => 1025371373, "title" => "Warranty information", "shop_id" => 548380009, "handle" => "warranty-information", "body_html" => "<h2>Warranty</h2>\n<p>Returns accepted if we receive items <strong>30 days after purchase</strong>.</p>", "author" => "Shopify API", "created_at" => "2022-04-05T13:25:22-04:00", "updated_at" => "2022-04-05T13:25:22-04:00", "published_at" => "2022-04-05T13:25:22-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/1025371373"}}), headers: {})

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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/pages.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 4}), headers: {})

    ShopifyAPI::Page.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages/count.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"id" => 131092082, "title" => "Terms of Services", "shop_id" => 548380009, "handle" => "tos", "body_html" => "<p>We make <strong>perfect</strong> stuff, we don't need a warranty.</p>", "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2008-07-16T20:00:00-04:00", "published_at" => "2008-07-15T20:00:00-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}}), headers: {})

    ShopifyAPI::Page.find(
      id: 131092082,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"body_html" => "<p>Returns accepted if we receive the items 14 days after purchase.</p>"}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"shop_id" => 548380009, "body_html" => "<p>Returns accepted if we receive the items 14 days after purchase.</p>", "title" => "Terms of Services", "handle" => "tos", "id" => 131092082, "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2022-04-05T13:25:29-04:00", "published_at" => "2008-07-15T20:00:00-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}}), headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.body_html = "<p>Returns accepted if we receive the items 14 days after purchase.</p>"
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"body_html" => "<p>Returns accepted if we receive the items <strong>14 days</strong> after purchase.</p>", "author" => "Christopher Gorski", "title" => "New warranty", "handle" => "new-warranty"}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"shop_id" => 548380009, "author" => "Christopher Gorski", "body_html" => "<p>Returns accepted if we receive the items <strong>14 days</strong> after purchase.</p>", "handle" => "new-warranty", "title" => "New warranty", "id" => 131092082, "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2022-04-05T13:25:30-04:00", "published_at" => "2008-07-15T20:00:00-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}}), headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.body_html = "<p>Returns accepted if we receive the items <strong>14 days</strong> after purchase.</p>"
    page.author = "Christopher Gorski"
    page.title = "New warranty"
    page.handle = "new-warranty"
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"published" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"shop_id" => 548380009, "published_at" => "2022-04-05T13:25:31-04:00", "title" => "Terms of Services", "handle" => "tos", "body_html" => "<p>We make <strong>perfect</strong> stuff, we don't need a warranty.</p>", "id" => 131092082, "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2022-04-05T13:25:31-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}}), headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.published = true
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"shop_id" => 548380009, "published_at" => nil, "title" => "Terms of Services", "handle" => "tos", "body_html" => "<p>We make <strong>perfect</strong> stuff, we don't need a warranty.</p>", "id" => 131092082, "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2022-04-05T13:25:32-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}}), headers: {})

    page = ShopifyAPI::Page.new
    page.id = 131092082
    page.published = false
    page.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "page" => hash_including({"metafields" => [{"key" => "new", "value" => "new value", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"page" => {"shop_id" => 548380009, "title" => "Terms of Services", "handle" => "tos", "body_html" => "<p>We make <strong>perfect</strong> stuff, we don't need a warranty.</p>", "id" => 131092082, "author" => "Dennis", "created_at" => "2008-07-15T20:00:00-04:00", "updated_at" => "2022-04-05T13:25:34-04:00", "published_at" => "2008-07-15T20:00:00-04:00", "template_suffix" => nil, "admin_graphql_api_id" => "gid://shopify/OnlineStorePage/131092082"}}), headers: {})

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

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Page.delete(
      id: 131092082,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/pages/131092082.json")
  end

end
