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

class Theme202301Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/themes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"themes" => [{"id" => 828155753, "name" => "Comfort", "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:46:47-04:00", "role" => "main", "theme_store_id" => nil, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/828155753"}, {"id" => 976877075, "name" => "Preview of Parallax", "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:46:47-04:00", "role" => "demo", "theme_store_id" => 688, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/976877075"}, {"id" => 752253240, "name" => "Sandbox", "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:46:47-04:00", "role" => "unpublished", "theme_store_id" => nil, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/752253240"}]}), headers: {})

    response = ShopifyAPI::Theme.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/themes.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/themes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "theme" => hash_including({"name" => "Lemongrass", "src" => "http://themes.shopify.com/theme.zip", "role" => "main"}) }
      )
      .to_return(status: 200, body: JSON.generate({"theme" => {"id" => 1049083723, "name" => "Lemongrass", "created_at" => "2023-10-03T13:49:23-04:00", "updated_at" => "2023-10-03T13:49:23-04:00", "role" => "unpublished", "theme_store_id" => nil, "previewable" => false, "processing" => true, "admin_graphql_api_id" => "gid://shopify/Theme/1049083723"}}), headers: {})

    response = theme = ShopifyAPI::Theme.new
    theme.name = "Lemongrass"
    theme.src = "http://themes.shopify.com/theme.zip"
    theme.role = "main"
    theme.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/themes.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/themes/828155753.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"theme" => {"id" => 828155753, "name" => "Comfort", "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:46:47-04:00", "role" => "main", "theme_store_id" => nil, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/828155753"}}), headers: {})

    response = ShopifyAPI::Theme.find(
      id: 828155753,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/themes/828155753.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/themes/752253240.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "theme" => hash_including({"role" => "main"}) }
      )
      .to_return(status: 200, body: JSON.generate({"theme" => {"role" => "main", "id" => 752253240, "name" => "Sandbox", "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:49:22-04:00", "theme_store_id" => nil, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/752253240"}}), headers: {})

    response = theme = ShopifyAPI::Theme.new
    theme.id = 752253240
    theme.role = "main"
    theme.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/themes/752253240.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/themes/752253240.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "theme" => hash_including({"name" => "Experimental"}) }
      )
      .to_return(status: 200, body: JSON.generate({"theme" => {"name" => "Experimental", "role" => "unpublished", "id" => 752253240, "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:49:19-04:00", "theme_store_id" => nil, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/752253240"}}), headers: {})

    response = theme = ShopifyAPI::Theme.new
    theme.id = 752253240
    theme.name = "Experimental"
    theme.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/themes/752253240.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/themes/752253240.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"id" => 752253240, "name" => "Sandbox", "created_at" => "2023-10-03T13:46:47-04:00", "updated_at" => "2023-10-03T13:46:47-04:00", "role" => "unpublished", "theme_store_id" => nil, "previewable" => true, "processing" => false, "admin_graphql_api_id" => "gid://shopify/Theme/752253240"}), headers: {})

    response = ShopifyAPI::Theme.delete(
      id: 752253240,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/themes/752253240.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

end
