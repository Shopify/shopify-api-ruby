# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Blog202201Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blogs" => [{"id" => 382285388, "handle" => "banana-blog", "title" => "A Gnu Blog", "updated_at" => "2006-02-02T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/382285388"}, {"id" => 241253187, "handle" => "apple-blog", "title" => "Mah Blog", "updated_at" => "2006-02-01T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}]}), headers: {})

    ShopifyAPI::Blog.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json?since_id=241253187")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blogs" => [{"id" => 382285388, "handle" => "banana-blog", "title" => "A Gnu Blog", "updated_at" => "2006-02-02T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/382285388"}, {"id" => 1008414258, "handle" => "apple-main-blog", "title" => "Apple main blog", "updated_at" => "2022-02-03T17:15:51-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:15:51-05:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/1008414258"}]}), headers: {})

    ShopifyAPI::Blog.all(
      since_id: "241253187",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json?since_id=241253187")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"title" => "Apple main blog"}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 1008414261, "handle" => "apple-main-blog", "title" => "Apple main blog", "updated_at" => "2022-02-03T17:16:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:16:00-05:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/1008414261"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.title = "Apple main blog"
    blog.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"title" => "Apple main blog", "metafields" => [{"key" => "sponsor", "value" => "Shopify", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 1008414262, "handle" => "apple-main-blog", "title" => "Apple main blog", "updated_at" => "2022-02-03T17:16:03-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:16:03-05:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/1008414262"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.title = "Apple main blog"
    blog.metafields = [
      {
        "key" => "sponsor",
        "value" => "Shopify",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    blog.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/blogs.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::Blog.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 241253187, "handle" => "apple-blog", "title" => "Mah Blog", "updated_at" => "2006-02-01T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    ShopifyAPI::Blog.find(
      id: 241253187,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json?fields=id%2Ctitle")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 241253187, "title" => "Mah Blog"}}), headers: {})

    ShopifyAPI::Blog.find(
      id: 241253187,
      fields: "id,title",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json?fields=id%2Ctitle")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"id" => 241253187, "title" => "IPod Updates"}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"title" => "IPod Updates", "handle" => "apple-blog", "id" => 241253187, "updated_at" => "2022-02-03T17:16:08-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.id = 241253187
    blog.title = "IPod Updates"
    blog.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"id" => 241253187, "title" => "IPod Updates", "handle" => "ipod-updates", "commentable" => "moderate"}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"title" => "IPod Updates", "handle" => "ipod-updates", "commentable" => "moderate", "id" => 241253187, "updated_at" => "2022-02-03T17:16:09-05:00", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.id = 241253187
    blog.title = "IPod Updates"
    blog.handle = "ipod-updates"
    blog.commentable = "moderate"
    blog.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"id" => 241253187, "metafields" => [{"key" => "sponsor", "value" => "Shopify", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"title" => "Mah Blog", "handle" => "apple-blog", "id" => 241253187, "updated_at" => "2022-02-03T17:16:11-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.id = 241253187
    blog.metafields = [
      {
        "key" => "sponsor",
        "value" => "Shopify",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    blog.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Blog.delete(
      id: 241253187,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/blogs/241253187.json")
  end

end
