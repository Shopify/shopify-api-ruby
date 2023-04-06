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

class ScriptTag202207Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tags" => [{"id" => 421379493, "src" => "https://js.example.org/bar.js", "event" => "onload", "created_at" => "2023-02-02T09:09:49-05:00", "updated_at" => "2023-02-02T09:09:49-05:00", "display_scope" => "all"}, {"id" => 596726825, "src" => "https://js.example.org/foo.js", "event" => "onload", "created_at" => "2023-02-02T09:09:49-05:00", "updated_at" => "2023-02-02T09:09:49-05:00", "display_scope" => "all"}]}), headers: {})

    ShopifyAPI::ScriptTag.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json?since_id=421379493")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tags" => [{"id" => 596726825, "src" => "https://js.example.org/foo.js", "event" => "onload", "created_at" => "2023-02-02T09:09:49-05:00", "updated_at" => "2023-02-02T09:09:49-05:00", "display_scope" => "all"}]}), headers: {})

    ShopifyAPI::ScriptTag.all(
      since_id: "421379493",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json?since_id=421379493")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json?src=https%3A%2F%2Fjs.example.org%2Ffoo.js")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tags" => [{"id" => 596726825, "src" => "https://js.example.org/foo.js", "event" => "onload", "created_at" => "2023-02-02T09:09:49-05:00", "updated_at" => "2023-02-02T09:09:49-05:00", "display_scope" => "all"}]}), headers: {})

    ShopifyAPI::ScriptTag.all(
      src: "https://js.example.org/foo.js",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json?src=https%3A%2F%2Fjs.example.org%2Ffoo.js")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "script_tag" => hash_including({"event" => "onload", "src" => "https://example.com/my_script.js"}) }
      )
      .to_return(status: 200, body: JSON.generate({"script_tag" => {"id" => 870402688, "src" => "https://example.com/my_script.js", "event" => "onload", "created_at" => "2023-02-02T09:14:37-05:00", "updated_at" => "2023-02-02T09:14:37-05:00", "display_scope" => "all", "cache" => false}}), headers: {})

    script_tag = ShopifyAPI::ScriptTag.new
    script_tag.event = "onload"
    script_tag.src = "https://example.com/my_script.js"
    script_tag.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::ScriptTag.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/596726825.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"script_tag" => {"id" => 596726825, "src" => "https://js.example.org/foo.js", "event" => "onload", "created_at" => "2023-02-02T09:09:49-05:00", "updated_at" => "2023-02-02T09:09:49-05:00", "display_scope" => "all", "cache" => false}}), headers: {})

    ShopifyAPI::ScriptTag.find(
      id: 596726825,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/596726825.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/596726825.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "script_tag" => hash_including({"src" => "https://somewhere-else.com/another.js"}) }
      )
      .to_return(status: 200, body: JSON.generate({"script_tag" => {"src" => "https://somewhere-else.com/another.js", "cache" => false, "id" => 596726825, "event" => "onload", "created_at" => "2023-02-02T09:09:49-05:00", "updated_at" => "2023-02-02T09:14:53-05:00", "display_scope" => "all"}}), headers: {})

    script_tag = ShopifyAPI::ScriptTag.new
    script_tag.id = 596726825
    script_tag.src = "https://somewhere-else.com/another.js"
    script_tag.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/596726825.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/596726825.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::ScriptTag.delete(
      id: 596726825,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/script_tags/596726825.json")
  end

end
