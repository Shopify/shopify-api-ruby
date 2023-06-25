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

class OrderRisk202304Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "risk" => hash_including({"message" => "This order came from an anonymous proxy", "recommendation" => "cancel", "score" => "1.0", "source" => "External", "cause_cancel" => true, "display" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"risk" => {"id" => 1029151490, "order_id" => 450789469, "checkout_id" => 901414060, "source" => "External", "score" => "1.0", "recommendation" => "cancel", "display" => true, "cause_cancel" => true, "message" => "This order came from an anonymous proxy", "merchant_message" => "This order came from an anonymous proxy"}}), headers: {})

    response = order_risk = ShopifyAPI::OrderRisk.new
    order_risk.order_id = 450789469
    order_risk.message = "This order came from an anonymous proxy"
    order_risk.recommendation = "cancel"
    order_risk.score = "1.0"
    order_risk.source = "External"
    order_risk.cause_cancel = true
    order_risk.display = true
    order_risk.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"risks" => [{"id" => 284138680, "order_id" => 450789469, "checkout_id" => nil, "source" => "External", "score" => "1.0", "recommendation" => "cancel", "display" => true, "cause_cancel" => true, "message" => "This order was placed from a proxy IP", "merchant_message" => "This order was placed from a proxy IP"}, {"id" => 1029151489, "order_id" => 450789469, "checkout_id" => 901414060, "source" => "External", "score" => "1.0", "recommendation" => "cancel", "display" => true, "cause_cancel" => true, "message" => "This order came from an anonymous proxy", "merchant_message" => "This order came from an anonymous proxy"}]}), headers: {})

    response = ShopifyAPI::OrderRisk.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks/284138680.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"risk" => {"id" => 284138680, "order_id" => 450789469, "checkout_id" => nil, "source" => "External", "score" => "1.0", "recommendation" => "cancel", "display" => true, "cause_cancel" => true, "message" => "This order was placed from a proxy IP", "merchant_message" => "This order was placed from a proxy IP"}}), headers: {})

    response = ShopifyAPI::OrderRisk.find(
      order_id: 450789469,
      id: 284138680,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks/284138680.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks/284138680.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "risk" => hash_including({"message" => "After further review, this is a legitimate order", "recommendation" => "accept", "source" => "External", "cause_cancel" => false, "score" => "0.0"}) }
      )
      .to_return(status: 200, body: JSON.generate({"risk" => {"order_id" => 450789469, "cause_cancel" => false, "message" => "After further review, this is a legitimate order", "recommendation" => "accept", "score" => "0.0", "source" => "External", "id" => 284138680, "checkout_id" => nil, "display" => true, "merchant_message" => "After further review, this is a legitimate order"}}), headers: {})

    response = order_risk = ShopifyAPI::OrderRisk.new
    order_risk.order_id = 450789469
    order_risk.id = 284138680
    order_risk.message = "After further review, this is a legitimate order"
    order_risk.recommendation = "accept"
    order_risk.source = "External"
    order_risk.cause_cancel = false
    order_risk.score = "0.0"
    order_risk.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks/284138680.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks/284138680.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::OrderRisk.delete(
      order_id: 450789469,
      id: 284138680,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/risks/284138680.json")

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
