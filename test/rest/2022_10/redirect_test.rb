# typed: strict
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Redirect202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json?since_id=668809255")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"redirects" => [{"id" => 950115854, "path" => "/ibook", "target" => "/products/macbook"}]}), headers: {})

    ShopifyAPI::Redirect.all(
      since_id: "668809255",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json?since_id=668809255")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"redirects" => [{"id" => 304339089, "path" => "/products.php", "target" => "/products"}, {"id" => 668809255, "path" => "/leopard", "target" => "/pages/macosx"}, {"id" => 950115854, "path" => "/ibook", "target" => "/products/macbook"}]}), headers: {})

    ShopifyAPI::Redirect.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::Redirect.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/count.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"redirect" => {"id" => 668809255, "path" => "/leopard", "target" => "/pages/macosx"}}), headers: {})

    ShopifyAPI::Redirect.find(
      id: 668809255,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/950115854.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({"path" => "/powermac", "target" => "/pages/macpro"}) }
      )
      .to_return(status: 200, body: JSON.generate({"redirect" => {"path" => "/powermac", "target" => "/pages/macpro", "id" => 950115854}}), headers: {})

    redirect = ShopifyAPI::Redirect.new
    redirect.id = 950115854
    redirect.path = "/powermac"
    redirect.target = "/pages/macpro"
    redirect.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/950115854.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({"path" => "/tiger"}) }
      )
      .to_return(status: 200, body: JSON.generate({"redirect" => {"path" => "/tiger", "target" => "/pages/macosx", "id" => 668809255}}), headers: {})

    redirect = ShopifyAPI::Redirect.new
    redirect.id = 668809255
    redirect.path = "/tiger"
    redirect.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({"target" => "/pages/macpro"}) }
      )
      .to_return(status: 200, body: JSON.generate({"redirect" => {"target" => "/pages/macpro", "path" => "/leopard", "id" => 668809255}}), headers: {})

    redirect = ShopifyAPI::Redirect.new
    redirect.id = 668809255
    redirect.target = "/pages/macpro"
    redirect.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Redirect.delete(
      id: 668809255,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({"path" => "/ipod", "target" => "/pages/itunes"}) }
      )
      .to_return(status: 200, body: JSON.generate({"redirect" => {"id" => 984542199, "path" => "/ipod", "target" => "/pages/itunes"}}), headers: {})

    redirect = ShopifyAPI::Redirect.new
    redirect.path = "/ipod"
    redirect.target = "/pages/itunes"
    redirect.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({"path" => "http://www.apple.com/forums", "target" => "http://forums.apple.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"redirect" => {"id" => 984542200, "path" => "/forums", "target" => "http://forums.apple.com/"}}), headers: {})

    redirect = ShopifyAPI::Redirect.new
    redirect.path = "http://www.apple.com/forums"
    redirect.target = "http://forums.apple.com"
    redirect.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/redirects.json")
  end

end
