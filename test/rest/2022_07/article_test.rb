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

class Article202207Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json?since_id=134645308")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"articles" => [{"id" => 294160202, "title" => "Just us bots here", "created_at" => "2013-11-06T19:00:00-05:00", "body_html" => "beep boop", "blog_id" => 241253187, "author" => "dennis", "user_id" => nil, "published_at" => nil, "updated_at" => "2022-10-03T12:44:45-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "just-us-bots-here", "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/294160202"}, {"id" => 989034056, "title" => "Some crazy article I'm coming up with", "created_at" => "2008-12-31T19:00:00-05:00", "body_html" => "I have no idea what to write about, but it's going to rock!", "blog_id" => 241253187, "author" => "John", "user_id" => nil, "published_at" => nil, "updated_at" => "2009-01-31T19:00:00-05:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "some-crazy-article-im-coming-up-with", "tags" => "Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/989034056"}, {"id" => 1051293780, "title" => "Welcome to the world of tomorrow!", "created_at" => "2013-11-06T19:00:00-05:00", "body_html" => "Good news, everybody!", "blog_id" => 241253187, "author" => "dennis", "user_id" => nil, "published_at" => nil, "updated_at" => "2022-10-03T12:44:45-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "welcome-to-the-world-of-tomorrow", "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293780"}]}), headers: {})

    ShopifyAPI::Article.all(
      blog_id: 241253187,
      since_id: "134645308",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json?since_id=134645308")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"articles" => [{"id" => 1051293780, "title" => "Welcome to the world of tomorrow!", "created_at" => "2013-11-06T19:00:00-05:00", "body_html" => "Good news, everybody!", "blog_id" => 241253187, "author" => "dennis", "user_id" => nil, "published_at" => nil, "updated_at" => "2022-10-03T12:44:45-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "welcome-to-the-world-of-tomorrow", "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293780"}, {"id" => 989034056, "title" => "Some crazy article I'm coming up with", "created_at" => "2008-12-31T19:00:00-05:00", "body_html" => "I have no idea what to write about, but it's going to rock!", "blog_id" => 241253187, "author" => "John", "user_id" => nil, "published_at" => nil, "updated_at" => "2009-01-31T19:00:00-05:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "some-crazy-article-im-coming-up-with", "tags" => "Mystery", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/989034056"}, {"id" => 294160202, "title" => "Just us bots here", "created_at" => "2013-11-06T19:00:00-05:00", "body_html" => "beep boop", "blog_id" => 241253187, "author" => "dennis", "user_id" => nil, "published_at" => nil, "updated_at" => "2022-10-03T12:44:45-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "just-us-bots-here", "tags" => "", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/294160202"}, {"id" => 134645308, "title" => "get on the train now", "created_at" => "2008-07-31T20:00:00-04:00", "body_html" => "<p>Do <em>you</em> have an <strong>IPod</strong> yet?</p>", "blog_id" => 241253187, "author" => "Dennis", "user_id" => 548380009, "published_at" => "2008-07-31T20:00:00-04:00", "updated_at" => "2008-07-31T20:00:00-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "get-on-the-train-now", "tags" => "Announcing", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:44:45-04:00", "alt" => "iMac", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/imac.jpg?v=1664815485"}}]}), headers: {})

    ShopifyAPI::Article.all(
      blog_id: 241253187,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 4}), headers: {})

    ShopifyAPI::Article.count(
      blog_id: 241253187,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/count.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"id" => 134645308, "title" => "get on the train now", "created_at" => "2008-07-31T20:00:00-04:00", "body_html" => "<p>Do <em>you</em> have an <strong>IPod</strong> yet?</p>", "blog_id" => 241253187, "author" => "Dennis", "user_id" => 548380009, "published_at" => "2008-07-31T20:00:00-04:00", "updated_at" => "2008-07-31T20:00:00-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "get-on-the-train-now", "tags" => "Announcing", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:44:45-04:00", "alt" => "iMac", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/imac.jpg?v=1664815485"}}}), headers: {})

    ShopifyAPI::Article.find(
      blog_id: 241253187,
      id: 134645308,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Title", "author" => "Your name", "tags" => "Tags, Will Be, Updated", "body_html" => "<p>Look, I can even update through a web service.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011"}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "author" => "Your name", "body_html" => "<p>Look, I can even update through a web service.</p>", "published_at" => "2011-03-24T11:45:47-04:00", "title" => "My new Title", "handle" => "get-on-the-train-now", "user_id" => nil, "id" => 134645308, "created_at" => "2008-07-31T20:00:00-04:00", "updated_at" => "2022-10-03T12:46:51-04:00", "summary_html" => nil, "template_suffix" => nil, "tags" => "Tags, Updated, Will Be", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:44:45-04:00", "alt" => "iMac", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/imac.jpg?v=1664815485"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.title = "My new Title"
    article.author = "Your name"
    article.tags = "Tags, Will Be, Updated"
    article.body_html = "<p>Look, I can even update through a web service.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Title", "author" => "Your name", "tags" => "Tags, Will Be, Updated", "body_html" => "<p>Look, I can even update through a web service.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011", "image" => {"alt" => "Rails logo"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "author" => "Your name", "body_html" => "<p>Look, I can even update through a web service.</p>", "published_at" => "2011-03-24T11:45:47-04:00", "title" => "My new Title", "handle" => "get-on-the-train-now", "id" => 134645308, "created_at" => "2008-07-31T20:00:00-04:00", "user_id" => nil, "updated_at" => "2022-10-03T12:47:19-04:00", "summary_html" => nil, "template_suffix" => nil, "tags" => "Tags, Updated, Will Be", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:47:18-04:00", "alt" => "Rails logo", "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/rails_logo20221003-23488-6gc29.gif?v=1664815639"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.title = "My new Title"
    article.author = "Your name"
    article.tags = "Tags, Will Be, Updated"
    article.body_html = "<p>Look, I can even update through a web service.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.image = {
      "alt" => "Rails logo"
    }
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"published" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "published_at" => "2022-10-03T12:47:23-04:00", "title" => "get on the train now", "handle" => "get-on-the-train-now", "body_html" => "<p>Do <em>you</em> have an <strong>IPod</strong> yet?</p>", "author" => "Dennis", "id" => 134645308, "created_at" => "2008-07-31T20:00:00-04:00", "user_id" => 548380009, "updated_at" => "2022-10-03T12:47:23-04:00", "summary_html" => nil, "template_suffix" => nil, "tags" => "Announcing", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:44:45-04:00", "alt" => "iMac", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/imac.jpg?v=1664815485"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.published = true
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Title", "author" => "Your name", "tags" => "Tags, Will Be, Updated", "body_html" => "<p>Look, I can even update through a web service.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011", "image" => {"attachment" => "R0lGODlhbgCMAPf/APbr48VySrxTO7IgKt2qmKQdJeK8lsFjROG5p/nz7Zg3\nMNmnd7Q1MLNVS9GId71hSJMZIuzTu4UtKbeEeakhKMl8U8WYjfr18YQaIbAf\nKKwhKdKzqpQtLebFortOOejKrOjZ1Mt7aMNpVbAqLLV7bsNqR+3WwMqEWenN\nsZYxL/Ddy/Pm2e7ZxLlUQrIjNPXp3bU5MbhENbEtLtqhj5ZQTfHh0bMxL7Ip\nNsNyUYkZIrZJPcqGdYIUHb5aPKkeJnoUHd2yiJkiLKYiKLRFOsyJXKVDO8up\nosFaS+TBnK4kKti5sNaYg/z49aqYl5kqLrljUtORfMOlo/36+H4ZH8yDYq0f\nKKFYTaU9MrY8MrZBNXwXHpgaIdGVYu/byLZNP9SaZLIyOuXCtHkpJst+Wpcm\nLMyCa8BfP9GMb9KQdPDd1PPk1sd5VP79/L5dQZ0bI9+ymqssK9WcfIoXHdzG\nxdWWfteib79lSr1YP86MYurQxKdcUKdMQr5ZSfPs6YEZH8uhl4oWIenMuurQ\nttmejaqoqsqBVaAcJLlJN5kvMLlZRMNsSL5fRak0LbdQQMVvSPjw6cJnRpkf\nKtmjhvfu5cJtT7IuOMVvWLY/M/37+o0YH9ibhtSYdObErc6HarM9NnYSGNGR\navLi09unje3WyeO8rsVrT7tdRtK3uffu6NWeaL9pTJIjJrM4NPbx8cdyX7M7\nPYYVHu7j4KgoNJAYIKtkV5o9MsOcldicis+RYNutfrhFOZ0hJbqinZ8bI8h5\nUObFuOfItJsfJrJfUOfIqc+PXqQtK8RnSbA4Mcd3Tm0SGbpXQ8aqp7RLNs+s\novHfzpVhV9iggMd1TLtbRKUdKXEQFsd4XrZRPLIgMZUeJ+jKvrAlK6AhJ65A\nMpMpKuC3j5obIsRwS7hAN8l/YtvDvnYXHbAoLI47SIUsOMenorF4gO/m4+fH\npo4vLZ8oKMukqp0cJbhVSMV2UuPR0bAfMLIrLrg/OcJwT8h+Vt+wn8eurLlh\nQrIfKHQOHHQOHf///////yH5BAEAAP8ALAAAAABuAIwAAAj/AP8JHDhQXjpz\n/PopXNiPn0OHDRMmbKhQIsOJFS1SxAhxI8SHFzVeDBnx48iNBAeeOkcxokeX\nFRdOnAlSokaaLXNujJkxo8iYHRkKtWkzZSsaOXkAWsoUECynsHgoqEW1qtVa\n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\nGg4lOnRGDKRZsoS7pMPSA6YXNWLsKJLkSZOVwKhMGSTTrJf9ZNKcomXKTrQY\nevr02cSIvKJxi6aJkaVuXaZMs1ziO5UqPawnuXK9AWEW2Jhja9pMuzMd27YW\nLNga10fuZYUPkdZdqpTv575YbJQbkCHw1sEpb9wQMstwWLFkbfppjJPc/wTI\nhHhJ5r0BBGbMRzfb7ez5MwwbpTMsx5pa9eob2CBM5yETpmzGtTE8hrybN29b\nc1oBn6trc9K7nhmUy6BcOUrn0KHLcr0FQvWYMxdnb3w7t/fvwFMiFvKG0uw8\n4kRLYjkGG0RtMPlWc+GGdyCwbwtYrOsHu7K0a+K/AEO04K0CF8InBvPOg2GE\nKpZTrsHSUotwwgnnmW4LHGGBKbb9bMqhsSly082CW0QMkDLLSvQHFQFiOESX\nLGzQpkUY22swA8Lko9EFLqfBEcdvMhRrwx610OLHtJ5Rc01ahHnCzTeFkXNO\nOfWQkwQ6NNFzTz2X0GQJQAMVdJEYsBhBAyrbK/9tgBcbrCTCG7bkkstvvvwm\nzPzI7JEcNLXDCYICQhXVkAIMMdWQd0x1Y9VdiuHGA1hjhfWQQzyg9dZDYmBg\nyioSVfRKFwfYZ8ZIJ3XhGhe83OLSSwEZU78ea+pUO2wK8MFaUUMl9dReDOll\n1VXbuYIZWWOl1dZDLpGhV3YZXLTR9vZhUMJijUX2mmveYRZcQDLlsCZOp21s\nCx+uLTjbbE/11ttv3diFkSHKRReGcthtN1hgrdxH2Awk5fJefK+ZZ9lvVvXW\n2cT+ZSwHgdHCpmCYDb4WYVNL7baXbsN9FdYYbKDA4otddBdYeffZx9iPjw35\nmmlKNtnUfmXSNNqAW9b/6eWYY8YWYW0V7tYQhxWAwwege61y6OXkbdDoSUFe\nWuR3wP3akKhjUtlHlqklG+YqsjaY620VNgQDMcQQouwrX3zR6KKFZfttyKtw\n+utQnRUL2mjLYjnvtLDpu9e9/ZYZ8FK3maLwwn8OmlF3lWNc7df3gfzteaZZ\n+NTKx5y6RxJ69/333mvBwHOLQ/fhiR2SV34HS47hmnAafJ9gh3AaDMcB7LE/\nIoPY441dhOzDz94VN3DPNmoeM5drAyfK7lWH34baYetVCidBIT6C5UMhB4r2\nn3FheSANRVGCwhBmObtlbgqXyYYNyuYFAMQFCtPwQf3spxAraGBRR+Af91wX\n/zsPoCIuCCAV13yAMsWo7zIOaJHFSHEZHZABdWK4X0JoIAENLIeDCXFA2rgX\nuwG8MC6kKGGoZuaDTEhtd/vBTBoyYLYqeAEzFpihGCagEBqIQQJVGMAOEdLD\n2L0uHJdBAMIOhsTELHExwLnS/i6zAQlIQItWxKIccejGL/4wjPvw4kHSQApA\nBhKQUDCiEWE2C93dTSEW2EMjaWABhbgnA3g8SAj4cElK+kMJWoyjBK6YECtw\nUgKZ7N8ejdZHfzjgGgNY5SpnZsisJXFHikwICTLBskzUECFtxJ/FFKKETmrx\nkwixQiclYAX+mfKUCpnBEZzpzHpkS2Yxm0ViMNcjhf+QABs5uKUuD9KoTOaP\nQb80picxaExk8lCZfIxLNuBhrWnurZpjoiVCbAkBbnrTH2pbTjgZVAVyGnOY\nBylmJ9P5xXWOUS6WEB3ZqgmTazLxMk40WntQub3lbIOc7OjkQP1RUI4e9CCl\nfJ3jjCbEogDAE6KrAiKlVs+4gJF7GUDlDLLnUWCyg6Ps8GgxdyrSVK5zH/WI\noARjZjFEQhSmRCEFg9SGSqIoQadT7alOJcAOoJJUmeFA6VBIETqk+ssPKizK\nDorxwx9CdShSvapOqzpVoO7ApMocgAdcIb74HeSroEOqEn8w1mgVRR0KyEEw\nKqoctTZEquzggFsVooepskP/DwqZAAfmakpGvc4HXSXF54CWVLthALASRYhB\nFpmDd4QxsQxRQmNd61HITnWyCVHC9MTnCsY9U7dH4AM8spGQvVrsiRB4Fg/8\ncFxsJmQDHvUHLQyhWsy01rXs2MFj2ZGC6862KKRgHGY6K9zlEPdyP8AJcteo\n3ClsQCHq0AF0QdkN+HbjlxygL31hO13tMrW7lwkB0BiUoR3x4EfmrYlCNjAF\nCRAoIWmwQexQqQcyxHe+9eXAfVOQAg7k16v7jQsAHGi2Bv0gUzyQQ05Ga+Cy\n0MBEDsZgN8gQ4QnXt7oJ0QOGOZACDTeEu0aTCwC80EKhDcAHMDGHWATMsuMC\nFsVl/9GnP0Jg0kw24MUv/qUTOGDlCj8WETfGsVx2vI+UzsATIFZUaTIRk3QY\n+ZYlFq0Ce5QJHBXgdU+MRCSwEYlVBCHPQZhyn7vhhD9fWdAc2DKhKXxhRCc6\n0Yi4LOPcl6hGVUFqc4gJLGaxufKO1s2VkrOj63znOkciCKMedZ+n7ARUp1rQ\niLAyIlyNYURcONaInrWs9ci4JyJOaFYawDzP8Q+ZwAICLckbgd08i290eh9V\nCIadQw3qO5Oa1H1GNRlSjeorO2HLruZ2rLudAm+Dm9Gxcx/GXmSIMbnjH5W2\nzy2RbOzM+cENBRAWs0N9b3zXWdp8pra1r61tbXdb4N/2Nv8i5gzeIJd5Gjui\nwT+AzQ9YVGrYnNO0Agm27GBkvNnNzje+921qf/+b1QEfuMDFPe5lk/lspUG3\nWKbQCofLBBBuwNEs3C3aikcrB2TTeM81HgmOd3zf/PZ3yFPNaqSXfODF0EDK\nE9e6liZmCvJwOLD7AQhU2efSbG6zm7VgiG1ofBc+//nGgZ7vbYw67aVux4v/\nfXSSK53by/HVrzIwDZTBBANUrzpMeAAIWASeB4P/AQ9+cHjEJx7xWgDE5nLQ\neMdHXvKbg/zkMZ23H/1oFRjYPOc9v3nQ58Aw0xn9LACvO7HQAOZVf/jl0ii1\nHcXe9bPX3euftaPL5R71tIf97nsy7/o0WlP2r4/JOU7B+r5nqva7jz1EdZ97\n4qNe+bonfvCfVXvly1762beOOdLBd+Q7PCAAOw==\n"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "author" => "Your name", "body_html" => "<p>Look, I can even update through a web service.</p>", "published_at" => "2011-03-24T11:45:47-04:00", "title" => "My new Title", "updated_at" => "2022-10-03T12:48:10-04:00", "id" => 134645308, "created_at" => "2008-07-31T20:00:00-04:00", "user_id" => nil, "summary_html" => nil, "template_suffix" => nil, "handle" => "get-on-the-train-now", "tags" => "Tags, Updated, Will Be", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:48:10-04:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/fd43f2c8883f6e9b680e3295fd990d2c.gif?v=1664815690"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.title = "My new Title"
    article.author = "Your name"
    article.tags = "Tags, Will Be, Updated"
    article.body_html = "<p>Look, I can even update through a web service.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.image = {
      "attachment" => "R0lGODlhbgCMAPf/APbr48VySrxTO7IgKt2qmKQdJeK8lsFjROG5p/nz7Zg3\nMNmnd7Q1MLNVS9GId71hSJMZIuzTu4UtKbeEeakhKMl8U8WYjfr18YQaIbAf\nKKwhKdKzqpQtLebFortOOejKrOjZ1Mt7aMNpVbAqLLV7bsNqR+3WwMqEWenN\nsZYxL/Ddy/Pm2e7ZxLlUQrIjNPXp3bU5MbhENbEtLtqhj5ZQTfHh0bMxL7Ip\nNsNyUYkZIrZJPcqGdYIUHb5aPKkeJnoUHd2yiJkiLKYiKLRFOsyJXKVDO8up\nosFaS+TBnK4kKti5sNaYg/z49aqYl5kqLrljUtORfMOlo/36+H4ZH8yDYq0f\nKKFYTaU9MrY8MrZBNXwXHpgaIdGVYu/byLZNP9SaZLIyOuXCtHkpJst+Wpcm\nLMyCa8BfP9GMb9KQdPDd1PPk1sd5VP79/L5dQZ0bI9+ymqssK9WcfIoXHdzG\nxdWWfteib79lSr1YP86MYurQxKdcUKdMQr5ZSfPs6YEZH8uhl4oWIenMuurQ\nttmejaqoqsqBVaAcJLlJN5kvMLlZRMNsSL5fRak0LbdQQMVvSPjw6cJnRpkf\nKtmjhvfu5cJtT7IuOMVvWLY/M/37+o0YH9ibhtSYdObErc6HarM9NnYSGNGR\navLi09unje3WyeO8rsVrT7tdRtK3uffu6NWeaL9pTJIjJrM4NPbx8cdyX7M7\nPYYVHu7j4KgoNJAYIKtkV5o9MsOcldicis+RYNutfrhFOZ0hJbqinZ8bI8h5\nUObFuOfItJsfJrJfUOfIqc+PXqQtK8RnSbA4Mcd3Tm0SGbpXQ8aqp7RLNs+s\novHfzpVhV9iggMd1TLtbRKUdKXEQFsd4XrZRPLIgMZUeJ+jKvrAlK6AhJ65A\nMpMpKuC3j5obIsRwS7hAN8l/YtvDvnYXHbAoLI47SIUsOMenorF4gO/m4+fH\npo4vLZ8oKMukqp0cJbhVSMV2UuPR0bAfMLIrLrg/OcJwT8h+Vt+wn8eurLlh\nQrIfKHQOHHQOHf///////yH5BAEAAP8ALAAAAABuAIwAAAj/AP8JHDhQXjpz\n/PopXNiPn0OHDRMmbKhQIsOJFS1SxAhxI8SHFzVeDBnx48iNBAeeOkcxokeX\nFRdOnAlSokaaLXNujJkxo8iYHRkKtWkzZSsaOXkAWsoUECynsHgoqEW1qtVa\n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\nGg4lOnRGDKRZsoS7pMPSA6YXNWLsKJLkSZOVwKhMGSTTrJf9ZNKcomXKTrQY\nevr02cSIvKJxi6aJkaVuXaZMs1ziO5UqPawnuXK9AWEW2Jhja9pMuzMd27YW\nLNga10fuZYUPkdZdqpTv575YbJQbkCHw1sEpb9wQMstwWLFkbfppjJPc/wTI\nhHhJ5r0BBGbMRzfb7ez5MwwbpTMsx5pa9eob2CBM5yETpmzGtTE8hrybN29b\nc1oBn6trc9K7nhmUy6BcOUrn0KHLcr0FQvWYMxdnb3w7t/fvwFMiFvKG0uw8\n4kRLYjkGG0RtMPlWc+GGdyCwbwtYrOsHu7K0a+K/AEO04K0CF8InBvPOg2GE\nKpZTrsHSUotwwgnnmW4LHGGBKbb9bMqhsSly082CW0QMkDLLSvQHFQFiOESX\nLGzQpkUY22swA8Lko9EFLqfBEcdvMhRrwx610OLHtJ5Rc01ahHnCzTeFkXNO\nOfWQkwQ6NNFzTz2X0GQJQAMVdJEYsBhBAyrbK/9tgBcbrCTCG7bkkstvvvwm\nzPzI7JEcNLXDCYICQhXVkAIMMdWQd0x1Y9VdiuHGA1hjhfWQQzyg9dZDYmBg\nyioSVfRKFwfYZ8ZIJ3XhGhe83OLSSwEZU78ea+pUO2wK8MFaUUMl9dReDOll\n1VXbuYIZWWOl1dZDLpGhV3YZXLTR9vZhUMJijUX2mmveYRZcQDLlsCZOp21s\nCx+uLTjbbE/11ttv3diFkSHKRReGcthtN1hgrdxH2Awk5fJefK+ZZ9lvVvXW\n2cT+ZSwHgdHCpmCYDb4WYVNL7baXbsN9FdYYbKDA4otddBdYeffZx9iPjw35\nmmlKNtnUfmXSNNqAW9b/6eWYY8YWYW0V7tYQhxWAwwege61y6OXkbdDoSUFe\nWuR3wP3akKhjUtlHlqklG+YqsjaY620VNgQDMcQQouwrX3zR6KKFZfttyKtw\n+utQnRUL2mjLYjnvtLDpu9e9/ZYZ8FK3maLwwn8OmlF3lWNc7df3gfzteaZZ\n+NTKx5y6RxJ69/333mvBwHOLQ/fhiR2SV34HS47hmnAafJ9gh3AaDMcB7LE/\nIoPY441dhOzDz94VN3DPNmoeM5drAyfK7lWH34baYetVCidBIT6C5UMhB4r2\nn3FheSANRVGCwhBmObtlbgqXyYYNyuYFAMQFCtPwQf3spxAraGBRR+Af91wX\n/zsPoCIuCCAV13yAMsWo7zIOaJHFSHEZHZABdWK4X0JoIAENLIeDCXFA2rgX\nuwG8MC6kKGGoZuaDTEhtd/vBTBoyYLYqeAEzFpihGCagEBqIQQJVGMAOEdLD\n2L0uHJdBAMIOhsTELHExwLnS/i6zAQlIQItWxKIccejGL/4wjPvw4kHSQApA\nBhKQUDCiEWE2C93dTSEW2EMjaWABhbgnA3g8SAj4cElK+kMJWoyjBK6YECtw\nUgKZ7N8ejdZHfzjgGgNY5SpnZsisJXFHikwICTLBskzUECFtxJ/FFKKETmrx\nkwixQiclYAX+mfKUCpnBEZzpzHpkS2Yxm0ViMNcjhf+QABs5uKUuD9KoTOaP\nQb80picxaExk8lCZfIxLNuBhrWnurZpjoiVCbAkBbnrTH2pbTjgZVAVyGnOY\nBylmJ9P5xXWOUS6WEB3ZqgmTazLxMk40WntQub3lbIOc7OjkQP1RUI4e9CCl\nfJ3jjCbEogDAE6KrAiKlVs+4gJF7GUDlDLLnUWCyg6Ps8GgxdyrSVK5zH/WI\noARjZjFEQhSmRCEFg9SGSqIoQadT7alOJcAOoJJUmeFA6VBIETqk+ssPKizK\nDorxwx9CdShSvapOqzpVoO7ApMocgAdcIb74HeSroEOqEn8w1mgVRR0KyEEw\nKqoctTZEquzggFsVooepskP/DwqZAAfmakpGvc4HXSXF54CWVLthALASRYhB\nFpmDd4QxsQxRQmNd61HITnWyCVHC9MTnCsY9U7dH4AM8spGQvVrsiRB4Fg/8\ncFxsJmQDHvUHLQyhWsy01rXs2MFj2ZGC6862KKRgHGY6K9zlEPdyP8AJcteo\n3ClsQCHq0AF0QdkN+HbjlxygL31hO13tMrW7lwkB0BiUoR3x4EfmrYlCNjAF\nCRAoIWmwQexQqQcyxHe+9eXAfVOQAg7k16v7jQsAHGi2Bv0gUzyQQ05Ga+Cy\n0MBEDsZgN8gQ4QnXt7oJ0QOGOZACDTeEu0aTCwC80EKhDcAHMDGHWATMsuMC\nFsVl/9GnP0Jg0kw24MUv/qUTOGDlCj8WETfGsVx2vI+UzsATIFZUaTIRk3QY\n+ZYlFq0Ce5QJHBXgdU+MRCSwEYlVBCHPQZhyn7vhhD9fWdAc2DKhKXxhRCc6\n0Yi4LOPcl6hGVUFqc4gJLGaxufKO1s2VkrOj63znOkciCKMedZ+n7ARUp1rQ\niLAyIlyNYURcONaInrWs9ci4JyJOaFYawDzP8Q+ZwAICLckbgd08i290eh9V\nCIadQw3qO5Oa1H1GNRlSjeorO2HLruZ2rLudAm+Dm9Gxcx/GXmSIMbnjH5W2\nzy2RbOzM+cENBRAWs0N9b3zXWdp8pra1r61tbXdb4N/2Nv8i5gzeIJd5Gjui\nwT+AzQ9YVGrYnNO0Agm27GBkvNnNzje+921qf/+b1QEfuMDFPe5lk/lspUG3\nWKbQCofLBBBuwNEs3C3aikcrB2TTeM81HgmOd3zf/PZ3yFPNaqSXfODF0EDK\nE9e6liZmCvJwOLD7AQhU2efSbG6zm7VgiG1ofBc+//nGgZ7vbYw67aVux4v/\nfXSSK53by/HVrzIwDZTBBANUrzpMeAAIWASeB4P/AQ9+cHjEJx7xWgDE5nLQ\neMdHXvKbg/zkMZ23H/1oFRjYPOc9v3nQ58Aw0xn9LACvO7HQAOZVf/jl0ii1\nHcXe9bPX3euftaPL5R71tIf97nsy7/o0WlP2r4/JOU7B+r5nqva7jz1EdZ97\n4qNe+bonfvCfVXvly1762beOOdLBd+Q7PCAAOw==\n"
    }
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "published_at" => nil, "title" => "get on the train now", "handle" => "get-on-the-train-now", "body_html" => "<p>Do <em>you</em> have an <strong>IPod</strong> yet?</p>", "author" => "Dennis", "id" => 134645308, "created_at" => "2008-07-31T20:00:00-04:00", "user_id" => 548380009, "updated_at" => "2022-10-03T12:48:53-04:00", "summary_html" => nil, "template_suffix" => nil, "tags" => "Announcing", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:44:45-04:00", "alt" => "iMac", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/imac.jpg?v=1664815485"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.published = false
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "title" => "get on the train now", "handle" => "get-on-the-train-now", "body_html" => "<p>Do <em>you</em> have an <strong>IPod</strong> yet?</p>", "author" => "Dennis", "id" => 134645308, "created_at" => "2008-07-31T20:00:00-04:00", "user_id" => 548380009, "published_at" => "2008-07-31T20:00:00-04:00", "updated_at" => "2022-10-03T12:48:56-04:00", "summary_html" => nil, "template_suffix" => nil, "tags" => "Announcing", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308", "image" => {"created_at" => "2022-10-03T12:44:45-04:00", "alt" => "iMac", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/imac.jpg?v=1664815485"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"image" => ""}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"blog_id" => 241253187, "updated_at" => "2022-10-03T12:49:00-04:00", "id" => 134645308, "title" => "get on the train now", "created_at" => "2008-07-31T20:00:00-04:00", "body_html" => "<p>Do <em>you</em> have an <strong>IPod</strong> yet?</p>", "author" => "Dennis", "user_id" => 548380009, "published_at" => "2008-07-31T20:00:00-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "get-on-the-train-now", "tags" => "Announcing", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/134645308"}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.id = 134645308
    article.image = ""
    article.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Article.delete(
      blog_id: 241253187,
      id: 134645308,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/134645308.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Article title", "author" => "John Smith", "tags" => "This Post, Has Been Tagged", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011", "image" => {"attachment" => "R0lGODlhAQABAIAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==\n"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"id" => 1051293784, "title" => "My new Article title", "created_at" => "2022-10-03T12:47:52-04:00", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "blog_id" => 241253187, "author" => "John Smith", "user_id" => 548380009, "published_at" => "2011-03-24T11:45:47-04:00", "updated_at" => "2022-10-03T12:47:52-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "my-new-article-title", "tags" => "Has Been Tagged, This Post", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293784", "image" => {"created_at" => "2022-10-03T12:47:52-04:00", "alt" => nil, "width" => 1, "height" => 1, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/df3e567d6f16d040326c7a0ea29a4f41.gif?v=1664815672"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.title = "My new Article title"
    article.author = "John Smith"
    article.tags = "This Post, Has Been Tagged"
    article.body_html = "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.image = {
      "attachment" => "R0lGODlhAQABAIAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==\n"
    }
    article.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Article title", "author" => "John Smith", "tags" => "This Post, Has Been Tagged", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011", "metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"id" => 1051293786, "title" => "My new Article title", "created_at" => "2022-10-03T12:48:37-04:00", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "blog_id" => 241253187, "author" => "John Smith", "user_id" => 548380009, "published_at" => "2011-03-24T11:45:47-04:00", "updated_at" => "2022-10-03T12:48:37-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "my-new-article-title", "tags" => "Has Been Tagged, This Post", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293786"}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.title = "My new Article title"
    article.author = "John Smith"
    article.tags = "This Post, Has Been Tagged"
    article.body_html = "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    article.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Article title", "author" => "John Smith", "tags" => "This Post, Has Been Tagged", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"id" => 1051293787, "title" => "My new Article title", "created_at" => "2022-10-03T12:48:40-04:00", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "blog_id" => 241253187, "author" => "John Smith", "user_id" => 548380009, "published_at" => nil, "updated_at" => "2022-10-03T12:48:40-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "my-new-article-title", "tags" => "Has Been Tagged, This Post", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293787"}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.title = "My new Article title"
    article.author = "John Smith"
    article.tags = "This Post, Has Been Tagged"
    article.body_html = "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>"
    article.published = false
    article.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Article title", "author" => "John Smith", "tags" => "This Post, Has Been Tagged", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011", "image" => {"src" => "http://example.com/rails_logo.gif", "alt" => "Rails logo"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"id" => 1051293788, "title" => "My new Article title", "created_at" => "2022-10-03T12:48:48-04:00", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "blog_id" => 241253187, "author" => "John Smith", "user_id" => 548380009, "published_at" => "2011-03-24T11:45:47-04:00", "updated_at" => "2022-10-03T12:48:49-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "my-new-article-title", "tags" => "Has Been Tagged, This Post", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293788", "image" => {"created_at" => "2022-10-03T12:48:49-04:00", "alt" => "Rails logo", "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/articles/rails_logo20221003-23488-ryyw9l.gif?v=1664815729"}}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.title = "My new Article title"
    article.author = "John Smith"
    article.tags = "This Post, Has Been Tagged"
    article.body_html = "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.image = {
      "src" => "http://example.com/rails_logo.gif",
      "alt" => "Rails logo"
    }
    article.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "article" => hash_including({"title" => "My new Article title", "author" => "John Smith", "tags" => "This Post, Has Been Tagged", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "published_at" => "Thu Mar 24 15:45:47 UTC 2011"}) }
      )
      .to_return(status: 200, body: JSON.generate({"article" => {"id" => 1051293792, "title" => "My new Article title", "created_at" => "2022-10-03T12:49:40-04:00", "body_html" => "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>", "blog_id" => 241253187, "author" => "John Smith", "user_id" => 548380009, "published_at" => "2011-03-24T11:45:47-04:00", "updated_at" => "2022-10-03T12:49:40-04:00", "summary_html" => nil, "template_suffix" => nil, "handle" => "my-new-article-title", "tags" => "Has Been Tagged, This Post", "admin_graphql_api_id" => "gid://shopify/OnlineStoreArticle/1051293792"}}), headers: {})

    article = ShopifyAPI::Article.new
    article.blog_id = 241253187
    article.title = "My new Article title"
    article.author = "John Smith"
    article.tags = "This Post, Has Been Tagged"
    article.body_html = "<h1>I like articles</h1>\n<p><strong>Yea</strong>, I like posting them through <span class=\"caps\">REST</span>.</p>"
    article.published_at = "Thu Mar 24 15:45:47 UTC 2011"
    article.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/articles/authors.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"authors" => ["dennis", "John", "Rob", "Dennis"]}), headers: {})

    ShopifyAPI::Article.authors

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/articles/authors.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/articles/tags.json?limit=1&popular=1")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tags" => ["Announcing"]}), headers: {})

    ShopifyAPI::Article.tags(
      limit: "1",
      popular: "1",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/articles/tags.json?limit=1&popular=1")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/articles/tags.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tags" => ["Announcing", "Mystery"]}), headers: {})

    ShopifyAPI::Article.tags

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/articles/tags.json")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/tags.json?limit=1&popular=1")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tags" => ["Announcing"]}), headers: {})

    ShopifyAPI::Article.tags(
      blog_id: 241253187,
      limit: "1",
      popular: "1",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/tags.json?limit=1&popular=1")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/tags.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tags" => ["Announcing", "Mystery"]}), headers: {})

    ShopifyAPI::Article.tags(
      blog_id: 241253187,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/blogs/241253187/articles/tags.json")
  end

end
