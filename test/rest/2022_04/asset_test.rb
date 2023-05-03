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

class Asset202204Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"assets" => [{"key" => "layout/theme.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 3252, "checksum" => nil, "theme_id" => 828155753}, {"key" => "assets/sidebar-devider.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/sidebar-devider.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 1016, "checksum" => "ed8d4b8c040fcac8b7e3ed0509bb297a", "theme_id" => 828155753}, {"key" => "assets/bg-body-pink.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-body-pink.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 1562, "checksum" => "d18b3a9b940cb1a20cf783923b9cacf8", "theme_id" => 828155753}, {"key" => "assets/bg-content.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-content.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 134, "checksum" => "7a5aab7934b2c80df50d061e70287507", "theme_id" => 828155753}, {"key" => "sections/header_section.liquid", "public_url" => nil, "created_at" => "2017-04-28T10:30:00-04:00", "updated_at" => "2017-04-28T10:30:00-04:00", "content_type" => "application/x-liquid", "size" => 998, "checksum" => nil, "theme_id" => 828155753}, {"key" => "assets/shop.css.liquid", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/shop.css.liquid?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "application/x-liquid", "size" => 14675, "checksum" => "1f559e456e88a5f8d0308ef861da9f28", "theme_id" => 828155753}, {"key" => "assets/shop.js", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/shop.js?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "application/javascript", "size" => 348, "checksum" => "88d7cbd167fbd3be0249f4f1f6e404ea", "theme_id" => 828155753}, {"key" => "assets/bg-main.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-main.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 297, "checksum" => "18905282d4955d4e4c5028da9ae88bca", "theme_id" => 828155753}, {"key" => "sections/content_section.liquid", "public_url" => nil, "created_at" => "2016-02-11T14:31:50-05:00", "updated_at" => "2016-02-11T14:31:50-05:00", "content_type" => "application/x-liquid", "size" => 997, "checksum" => nil, "theme_id" => 828155753}, {"key" => "templates/page.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 147, "checksum" => nil, "theme_id" => 828155753}, {"key" => "assets/bg-body-green.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-body-green.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 1542, "checksum" => "2169a9ff29848ec56359263d0a8d8166", "theme_id" => 828155753}, {"key" => "assets/shop.css", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/shop.css?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "text/css", "size" => 14138, "checksum" => "b3d706d74997b378c0cac8dbdcf75695", "theme_id" => 828155753}, {"key" => "config/settings_schema.json", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/json", "size" => 4570, "checksum" => nil, "theme_id" => 828155753}, {"key" => "sections/product_section.liquid", "public_url" => nil, "created_at" => "2016-02-14T16:31:41-05:00", "updated_at" => "2016-02-14T16:31:41-05:00", "content_type" => "application/x-liquid", "size" => 2440, "checksum" => nil, "theme_id" => 828155753}, {"key" => "templates/blog.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 786, "checksum" => nil, "theme_id" => 828155753}, {"key" => "templates/article.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 2486, "checksum" => nil, "theme_id" => 828155753}, {"key" => "templates/product.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 2796, "checksum" => nil, "theme_id" => 828155753}, {"key" => "sections/footer_section.liquid", "public_url" => nil, "created_at" => "2017-04-28T10:30:00-04:00", "updated_at" => "2017-04-28T10:30:00-04:00", "content_type" => "application/x-liquid", "size" => 999, "checksum" => nil, "theme_id" => 828155753}, {"key" => "assets/bg-footer.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-footer.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 1434, "checksum" => "f90351e66f70b0ffc3a84f9e60f4ecf9", "theme_id" => 828155753}, {"key" => "assets/bg-sidebar.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-sidebar.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 124, "checksum" => "e3c398a169841859e330e264363ddadd", "theme_id" => 828155753}, {"key" => "assets/bg-body-orange.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-body-orange.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 1548, "checksum" => "e6f3b060844d9b49d849b42cf721d641", "theme_id" => 828155753}, {"key" => "templates/collection.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 946, "checksum" => nil, "theme_id" => 828155753}, {"key" => "assets/sidebar-menu.jpg", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/sidebar-menu.jpg?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/jpeg", "size" => 1609, "checksum" => "ed24e939ab1831d4528928492b067221", "theme_id" => 828155753}, {"key" => "templates/cart.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 2047, "checksum" => nil, "theme_id" => 828155753}, {"key" => "config/settings_data.json", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/json", "size" => 4570, "checksum" => nil, "theme_id" => 828155753}, {"key" => "templates/index.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 1068, "checksum" => nil, "theme_id" => 828155753}, {"key" => "assets/bg-body.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-body.gif?v=1677080922", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:48:42-05:00", "content_type" => "image/gif", "size" => 1571, "checksum" => "141775df5ce156a7cb50732a22689ff7", "theme_id" => 828155753}]}), headers: {})

    ShopifyAPI::Asset.all(
      theme_id: 828155753,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "templates/index.liquid", "value" => "<img src='backsoon-postit.png'><p>We are busy updating the store for you and will be back within the hour.</p>"}) }
      )
      .to_return(status: 200, body: JSON.generate({"asset" => {"key" => "templates/index.liquid", "public_url" => nil, "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:49:10-05:00", "content_type" => "application/x-liquid", "size" => 110, "checksum" => "cd71db2e14df976c8aa44b44c8dae77b", "theme_id" => 828155753}}), headers: {})

    asset = ShopifyAPI::Asset.new
    asset.theme_id = 828155753
    asset.key = "templates/index.liquid"
    asset.value = "<img src='backsoon-postit.png'><p>We are busy updating the store for you and will be back within the hour.</p>"
    asset.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "assets/empty.gif", "attachment" => "R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==\n"}) }
      )
      .to_return(status: 200, body: JSON.generate({"asset" => {"key" => "assets/empty.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/empty.gif?v=1677080945", "created_at" => "2023-02-22T10:49:05-05:00", "updated_at" => "2023-02-22T10:49:05-05:00", "content_type" => "image/gif", "size" => 43, "checksum" => "45cf913e5d9d3c9b2058033056d3dd23", "theme_id" => 828155753}}), headers: {})

    asset = ShopifyAPI::Asset.new
    asset.theme_id = 828155753
    asset.key = "assets/empty.gif"
    asset.attachment = "R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==\n"
    asset.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "assets/bg-body.gif", "src" => "http://example.com/new_bg.gif"}) }
      )
      .to_return(status: 200, body: JSON.generate({"asset" => {"key" => "assets/bg-body.gif", "public_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/t/1/assets/bg-body.gif?v=1677080952", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2023-02-22T10:49:12-05:00", "content_type" => "image/gif", "size" => 43, "checksum" => "45cf913e5d9d3c9b2058033056d3dd23", "theme_id" => 828155753}}), headers: {})

    asset = ShopifyAPI::Asset.new
    asset.theme_id = 828155753
    asset.key = "assets/bg-body.gif"
    asset.src = "http://example.com/new_bg.gif"
    asset.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "asset" => hash_including({"key" => "layout/alternate.liquid", "source_key" => "layout/theme.liquid"}) }
      )
      .to_return(status: 200, body: JSON.generate({"asset" => {"key" => "layout/alternate.liquid", "public_url" => nil, "created_at" => "2023-02-22T10:49:15-05:00", "updated_at" => "2023-02-22T10:49:15-05:00", "content_type" => "application/x-liquid", "size" => 3049, "checksum" => "1879a06996941b2ff1ff485a1fe60a97", "theme_id" => 828155753}}), headers: {})

    asset = ShopifyAPI::Asset.new
    asset.theme_id = 828155753
    asset.key = "layout/alternate.liquid"
    asset.source_key = "layout/theme.liquid"
    asset.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json?asset%5Bkey%5D=templates%2Findex.liquid")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"asset" => {"key" => "templates/index.liquid", "public_url" => nil, "value" => "<!-- LIST 3 PER ROW -->\n<h2>Featured Products</h2>\n<table id=\"products\" cellspacing=\"0\" cellpadding=\"0\">\n  {% tablerow product in collections.frontpage.products cols:3 %}\n    <a href=\"{{product.url}}\">{{ product.featured_image | product_img_url: 'small' | img_tag }}</a>\n    <h3><a href=\"{{product.url}}\">{{product.title}}</a></h3>\n    <ul class=\"attributes\">\n      <li><span class=\"money\">{{product.price_min | money}}</span></li>\n    </ul>\n  {% endtablerow %}\n</table>\n<!-- /LIST 3 PER ROW -->\n\n{{ content_for_index }}\n\n<div id=\"articles\">\n  {% assign article = pages.frontpage %}\n  <div class=\"article\">\n    {% if article.content != \"\" %}\n      <h3>{{ article.title }}</h3>\n      <div class=\"article-body textile\">\n        {{ article.content }}\n      </div>\n    {% else %}\n      <div class=\"article-body textile\">\n        In <em>Admin &gt; Blogs &amp; Pages</em>, create a page with the handle <strong><code>frontpage</code></strong> and it will show up here.\n        <br />\n        {{ \"Learn more about handles\" | link_to \"http://wiki.shopify.com/Handle\" }}\n      </div>\n    {% endif %}\n  </div>\n</div>\n", "created_at" => "2010-07-12T15:31:50-04:00", "updated_at" => "2010-07-12T15:31:50-04:00", "content_type" => "application/x-liquid", "size" => 1068, "checksum" => nil, "theme_id" => 828155753}}), headers: {})

    ShopifyAPI::Asset.all(
      theme_id: 828155753,
      asset: {"key" => "templates/index.liquid"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json?asset%5Bkey%5D=templates%2Findex.liquid")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json?asset%5Bkey%5D=assets%2Fbg-body.gif")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"message" => "assets/bg-body.gif was successfully deleted"}), headers: {})

    ShopifyAPI::Asset.delete(
      theme_id: 828155753,
      asset: {"key" => "assets/bg-body.gif"},
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/themes/828155753/assets.json?asset%5Bkey%5D=assets%2Fbg-body.gif")
  end

end
