# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ScriptTag202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ScriptTag.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json?src=https%3A%2F%2Fjs-aplenty.com%2Ffoo.js")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ScriptTag.all(
      session: @test_session,
      src: "https://js-aplenty.com/foo.js",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json?src=https%3A%2F%2Fjs-aplenty.com%2Ffoo.js")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json?since_id=421379493")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ScriptTag.all(
      session: @test_session,
      since_id: "421379493",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json?since_id=421379493")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "script_tag" => hash_including({event: "onload", src: "https://djavaskripped.org/fancy.js"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    script_tag = ShopifyAPI::ScriptTag.new(session: @test_session)
    script_tag.event = "onload"
    script_tag.src = "https://djavaskripped.org/fancy.js"
    script_tag.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/count.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ScriptTag.count(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ScriptTag.find(
      session: @test_session,
      id: "596726825",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "script_tag" => hash_including({id: 596726825, src: "https://somewhere-else.com/another.js"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    script_tag = ShopifyAPI::ScriptTag.new(session: @test_session)
    script_tag.id = 596726825
    script_tag.src = "https://somewhere-else.com/another.js"
    script_tag.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ScriptTag.delete(
      session: @test_session,
      id: "596726825",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
  end

end
