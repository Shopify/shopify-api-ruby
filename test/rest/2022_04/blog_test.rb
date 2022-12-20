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

class Blog202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blogs" => [{"id" => 382285388, "handle" => "banana-blog", "title" => "A Gnu Blog", "updated_at" => "2006-02-02T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/382285388"}, {"id" => 241253187, "handle" => "apple-blog", "title" => "Mah Blog", "updated_at" => "2006-02-01T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}]}), headers: {})

    ShopifyAPI::Blog.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json?since_id=241253187")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blogs" => [{"id" => 382285388, "handle" => "banana-blog", "title" => "A Gnu Blog", "updated_at" => "2006-02-02T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/382285388"}, {"id" => 1008414250, "handle" => "apple-main-blog", "title" => "Apple main blog", "updated_at" => "2022-10-11T13:03:48-04:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:48-04:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/1008414250"}]}), headers: {})

    ShopifyAPI::Blog.all(
      since_id: "241253187",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json?since_id=241253187")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"title" => "Apple main blog", "metafields" => [{"key" => "sponsor", "value" => "Shopify", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 1008414248, "handle" => "apple-main-blog", "title" => "Apple main blog", "updated_at" => "2022-10-11T13:03:41-04:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:41-04:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/1008414248"}}), headers: {})

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
    blog.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"title" => "Apple main blog"}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 1008414253, "handle" => "apple-main-blog", "title" => "Apple main blog", "updated_at" => "2022-10-11T13:04:01-04:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:04:01-04:00", "template_suffix" => nil, "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/1008414253"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.title = "Apple main blog"
    blog.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/blogs.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::Blog.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json?fields=id%2Ctitle")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 241253187, "title" => "Mah Blog"}}), headers: {})

    ShopifyAPI::Blog.find(
      id: 241253187,
      fields: "id,title",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json?fields=id%2Ctitle")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"id" => 241253187, "handle" => "apple-blog", "title" => "Mah Blog", "updated_at" => "2006-02-01T19:00:00-05:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    ShopifyAPI::Blog.find(
      id: 241253187,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"metafields" => [{"key" => "sponsor", "value" => "Shopify", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"title" => "Mah Blog", "handle" => "apple-blog", "id" => 241253187, "updated_at" => "2022-10-11T13:03:39-04:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

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
    blog.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"title" => "IPod Updates"}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"title" => "IPod Updates", "handle" => "apple-blog", "id" => 241253187, "updated_at" => "2022-10-11T13:03:45-04:00", "commentable" => "no", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.id = 241253187
    blog.title = "IPod Updates"
    blog.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "blog" => hash_including({"title" => "IPod Updates", "handle" => "ipod-updates", "commentable" => "moderate"}) }
      )
      .to_return(status: 200, body: JSON.generate({"blog" => {"title" => "IPod Updates", "handle" => "ipod-updates", "commentable" => "moderate", "id" => 241253187, "updated_at" => "2022-10-11T13:03:46-04:00", "feedburner" => nil, "feedburner_location" => nil, "created_at" => "2022-10-11T13:03:14-04:00", "template_suffix" => nil, "tags" => "Announcing, Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreBlog/241253187"}}), headers: {})

    blog = ShopifyAPI::Blog.new
    blog.id = 241253187
    blog.title = "IPod Updates"
    blog.handle = "ipod-updates"
    blog.commentable = "moderate"
    blog.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Blog.delete(
      id: 241253187,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/blogs/241253187.json")
  end

end
