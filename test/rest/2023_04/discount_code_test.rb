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

class DiscountCode202304Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "discount_code" => hash_including({"code" => "SUMMERSALE10OFF"}) }
      )
      .to_return(status: 200, body: JSON.generate({"discount_code" => {"id" => 1054381139, "price_rule_id" => 507328175, "code" => "SUMMERSALE10OFF", "usage_count" => 0, "created_at" => "2023-05-03T16:04:22-04:00", "updated_at" => "2023-05-03T16:04:22-04:00"}}), headers: {})

    response = discount_code = ShopifyAPI::DiscountCode.new
    discount_code.price_rule_id = 507328175
    discount_code.code = "SUMMERSALE10OFF"
    discount_code.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"discount_codes" => [{"id" => 507328175, "price_rule_id" => 507328175, "code" => "SUMMERSALE10OFF", "usage_count" => 0, "created_at" => "2023-05-03T16:03:03-04:00", "updated_at" => "2023-05-03T16:03:03-04:00"}]}), headers: {})

    response = ShopifyAPI::DiscountCode.all(
      price_rule_id: 507328175,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "discount_code" => hash_including({"code" => "WINTERSALE20OFF"}) }
      )
      .to_return(status: 200, body: JSON.generate({"discount_code" => {"id" => 507328175, "price_rule_id" => 507328175, "code" => "WINTERSALE20OFF", "usage_count" => 0, "created_at" => "2023-05-03T16:03:03-04:00", "updated_at" => "2023-05-03T16:04:26-04:00"}}), headers: {})

    response = discount_code = ShopifyAPI::DiscountCode.new
    discount_code.price_rule_id = 507328175
    discount_code.id = 507328175
    discount_code.code = "WINTERSALE20OFF"
    discount_code.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes/507328175.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"discount_code" => {"id" => 507328175, "price_rule_id" => 507328175, "code" => "SUMMERSALE10OFF", "usage_count" => 0, "created_at" => "2023-05-03T16:03:03-04:00", "updated_at" => "2023-05-03T16:03:03-04:00"}}), headers: {})

    response = ShopifyAPI::DiscountCode.find(
      price_rule_id: 507328175,
      id: 507328175,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes/507328175.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::DiscountCode.delete(
      price_rule_id: 507328175,
      id: 507328175,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/discount_codes/507328175.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/discount_codes/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    response = ShopifyAPI::DiscountCode.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/discount_codes/count.json")

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
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/batch.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"discount_codes" => [{"code" => "SUMMER1"}, {"code" => "SUMMER2"}, {"code" => "SUMMER3"}]})
      )
      .to_return(status: 200, body: JSON.generate({"discount_code_creation" => {"id" => 989355119, "price_rule_id" => 507328175, "started_at" => nil, "completed_at" => nil, "created_at" => "2023-05-03T16:04:28-04:00", "updated_at" => "2023-05-03T16:04:28-04:00", "status" => "queued", "codes_count" => 3, "imported_count" => 0, "failed_count" => 0, "logs" => []}}), headers: {})

    response = discount_code = ShopifyAPI::DiscountCode.new
    discount_code.price_rule_id = 507328175
    discount_code.batch(
      body: {"discount_codes" => [{"code" => "SUMMER1"}, {"code" => "SUMMER2"}, {"code" => "SUMMER3"}]},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/batch.json")

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
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/batch/173232803.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"discount_code_creation" => {"id" => 173232803, "price_rule_id" => 507328175, "started_at" => nil, "completed_at" => nil, "created_at" => "2023-05-03T16:03:03-04:00", "updated_at" => "2023-05-03T16:03:03-04:00", "status" => "queued", "codes_count" => 3, "imported_count" => 0, "failed_count" => 0, "logs" => []}}), headers: {})

    response = ShopifyAPI::DiscountCode.get_all(
      price_rule_id: 507328175,
      batch_id: 173232803,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/batch/173232803.json")

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
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/batch/173232803/discount_codes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"discount_codes" => [{"id" => nil, "code" => "foo", "errors" => {}}, {"id" => nil, "code" => "", "errors" => {}}, {"id" => nil, "code" => "bar", "errors" => {}}]}), headers: {})

    response = ShopifyAPI::DiscountCode.all(
      price_rule_id: 507328175,
      batch_id: 173232803,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/price_rules/507328175/batch/173232803/discount_codes.json")

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
