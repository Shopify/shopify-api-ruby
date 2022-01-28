# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Blog202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Blog.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json?since_id=241253187")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Blog.all(
      session: @test_session,
      since_id: "241253187",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json?since_id=241253187")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({title: "Apple main blog"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    blog = ShopifyAPI::Blog.new(session: @test_session)
    blog.title = "Apple main blog"
    blog.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({title: "Apple main blog", metafields: [{key: "sponsor", value: "Shopify", type: "single_line_text_field", namespace: "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    blog = ShopifyAPI::Blog.new(session: @test_session)
    blog.title = "Apple main blog"
    blog.metafields = [
      {
        key: "sponsor",
        value: "Shopify",
        type: "single_line_text_field",
        namespace: "global"
      }
    ]
    blog.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/count.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Blog.count(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Blog.find(
      session: @test_session,
      id: "241253187",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json?fields=id%2Ctitle")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Blog.find(
      session: @test_session,
      id: "241253187",
      fields: "id,title",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json?fields=id%2Ctitle")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({id: 241253187, title: "IPod Updates"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    blog = ShopifyAPI::Blog.new(session: @test_session)
    blog.id = 241253187
    blog.title = "IPod Updates"
    blog.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({id: 241253187, title: "IPod Updates", handle: "ipod-updates", commentable: "moderate"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    blog = ShopifyAPI::Blog.new(session: @test_session)
    blog.id = 241253187
    blog.title = "IPod Updates"
    blog.handle = "ipod-updates"
    blog.commentable = "moderate"
    blog.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({id: 241253187, metafields: [{key: "sponsor", value: "Shopify", type: "single_line_text_field", namespace: "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    blog = ShopifyAPI::Blog.new(session: @test_session)
    blog.id = 241253187
    blog.metafields = [
      {
        key: "sponsor",
        value: "Shopify",
        type: "single_line_text_field",
        namespace: "global"
      }
    ]
    blog.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Blog.delete(
      session: @test_session,
      id: "241253187",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/blogs/241253187.json")
  end

end
