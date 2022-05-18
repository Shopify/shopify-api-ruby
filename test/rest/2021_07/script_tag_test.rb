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

class ScriptTag202107Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tags" => [{"id" => 421379493, "src" => "https://js-aplenty.com/bar.js", "event" => "onload", "created_at" => "2022-04-05T12:51:55-04:00", "updated_at" => "2022-04-05T12:51:55-04:00", "display_scope" => "all"}, {"id" => 596726825, "src" => "https://js-aplenty.com/foo.js", "event" => "onload", "created_at" => "2022-04-05T12:51:55-04:00", "updated_at" => "2022-04-05T12:51:55-04:00", "display_scope" => "all"}]}), headers: {})

    ShopifyAPI::ScriptTag.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json?src=https%3A%2F%2Fjs-aplenty.com%2Ffoo.js")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tags" => [{"id" => 596726825, "src" => "https://js-aplenty.com/foo.js", "event" => "onload", "created_at" => "2022-04-05T12:51:55-04:00", "updated_at" => "2022-04-05T12:51:55-04:00", "display_scope" => "all"}]}), headers: {})

    ShopifyAPI::ScriptTag.all(
      src: "https://js-aplenty.com/foo.js",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json?src=https%3A%2F%2Fjs-aplenty.com%2Ffoo.js")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json?since_id=421379493")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tags" => [{"id" => 596726825, "src" => "https://js-aplenty.com/foo.js", "event" => "onload", "created_at" => "2022-04-05T12:51:55-04:00", "updated_at" => "2022-04-05T12:51:55-04:00", "display_scope" => "all"}]}), headers: {})

    ShopifyAPI::ScriptTag.all(
      since_id: "421379493",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json?since_id=421379493")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "script_tag" => hash_including({"event" => "onload", "src" => "https://djavaskripped.org/fancy.js"}) }
      )
      .to_return(status: 200, body: JSON.generate({"script_tag" => {"id" => 870402687, "src" => "https://djavaskripped.org/fancy.js", "event" => "onload", "created_at" => "2022-04-05T12:53:25-04:00", "updated_at" => "2022-04-05T12:53:25-04:00", "display_scope" => "all", "cache" => false}}), headers: {})

    script_tag = ShopifyAPI::ScriptTag.new
    script_tag.event = "onload"
    script_tag.src = "https://djavaskripped.org/fancy.js"
    script_tag.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::ScriptTag.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tag" => {"id" => 596726825, "src" => "https://js-aplenty.com/foo.js", "event" => "onload", "created_at" => "2022-04-05T12:51:55-04:00", "updated_at" => "2022-04-05T12:51:55-04:00", "display_scope" => "all", "cache" => false}}), headers: {})

    ShopifyAPI::ScriptTag.find(
      id: 596726825,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "script_tag" => hash_including({"src" => "https://somewhere-else.com/another.js"}) }
      )
      .to_return(status: 200, body: JSON.generate({"script_tag" => {"src" => "https://somewhere-else.com/another.js", "cache" => false, "id" => 596726825, "event" => "onload", "created_at" => "2022-04-05T12:51:55-04:00", "updated_at" => "2022-04-05T12:53:27-04:00", "display_scope" => "all"}}), headers: {})

    script_tag = ShopifyAPI::ScriptTag.new
    script_tag.id = 596726825
    script_tag.src = "https://somewhere-else.com/another.js"
    script_tag.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::ScriptTag.delete(
      id: 596726825,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/script_tags/596726825.json")
  end

end
