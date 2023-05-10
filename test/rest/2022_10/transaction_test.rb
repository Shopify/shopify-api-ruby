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

class Transaction202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"transactions" => [{"id" => 179259969, "order_id" => 450789469, "kind" => "refund", "gateway" => "bogus", "status" => "success", "message" => nil, "created_at" => "2005-08-05T12:59:12-04:00", "test" => false, "authorization" => "authorization-key", "location_id" => nil, "user_id" => nil, "parent_id" => 801038806, "processed_at" => "2005-08-05T12:59:12-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "web", "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "209.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/179259969"}, {"id" => 389404469, "order_id" => 450789469, "kind" => "authorization", "gateway" => "bogus", "status" => "success", "message" => nil, "created_at" => "2005-08-01T11:57:11-04:00", "test" => false, "authorization" => "authorization-key", "location_id" => nil, "user_id" => nil, "parent_id" => nil, "processed_at" => "2005-08-01T11:57:11-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "web", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {"testcase" => true, "authorization" => "123456"}, "currency_exchange_adjustment" => nil, "amount" => "598.94", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/389404469"}, {"id" => 801038806, "order_id" => 450789469, "kind" => "capture", "gateway" => "bogus", "status" => "success", "message" => nil, "created_at" => "2005-08-05T10:22:51-04:00", "test" => false, "authorization" => "authorization-key", "location_id" => nil, "user_id" => nil, "parent_id" => 389404469, "processed_at" => "2005-08-05T10:22:51-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "web", "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "250.94", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/801038806"}]}), headers: {})

    response = ShopifyAPI::Transaction.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json?since_id=801038806")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"transactions" => [{"id" => 1068278466, "order_id" => 450789469, "kind" => "capture", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2023-05-01T15:39:12-04:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 389404469, "processed_at" => "2023-05-01T15:39:12-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "10.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278466"}]}), headers: {})

    response = ShopifyAPI::Transaction.all(
      order_id: 450789469,
      since_id: "801038806",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json?since_id=801038806")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"currency" => "USD", "amount" => "10.00", "kind" => "capture", "parent_id" => 389404469}) }
      )
      .to_return(status: 200, body: JSON.generate({"transaction" => {"id" => 1068278472, "order_id" => 450789469, "kind" => "capture", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2023-05-01T15:39:25-04:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 389404469, "processed_at" => "2023-05-01T15:39:25-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "10.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278472"}}), headers: {})

    response = transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.currency = "USD"
    transaction.amount = "10.00"
    transaction.kind = "capture"
    transaction.parent_id = 389404469
    transaction.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"kind" => "capture", "authorization" => "authorization-key"}) }
      )
      .to_return(status: 200, body: JSON.generate({"transaction" => {"id" => 1068278475, "order_id" => 450789469, "kind" => "capture", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2023-05-01T15:39:31-04:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 389404469, "processed_at" => "2023-05-01T15:39:31-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "598.94", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278475"}}), headers: {})

    response = transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.kind = "capture"
    transaction.authorization = "authorization-key"
    transaction.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"currency" => "USD", "amount" => "10.00", "kind" => "capture", "parent_id" => 389404469, "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"transaction" => {"id" => 1068278465, "order_id" => 450789469, "kind" => "capture", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2023-05-01T15:39:11-04:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 389404469, "processed_at" => "2023-05-01T15:39:11-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "10.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278465"}}), headers: {})

    response = transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.currency = "USD"
    transaction.amount = "10.00"
    transaction.kind = "capture"
    transaction.parent_id = 389404469
    transaction.test = true
    transaction.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"currency" => "USD", "amount" => "10.00", "kind" => "void", "parent_id" => 389404469}) }
      )
      .to_return(status: 200, body: JSON.generate({"transaction" => {"id" => 1068278464, "order_id" => 450789469, "kind" => "void", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2023-05-01T15:39:07-04:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 389404469, "processed_at" => "2023-05-01T15:39:07-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {}, "currency_exchange_adjustment" => nil, "amount" => "0.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278464"}}), headers: {})

    response = transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.currency = "USD"
    transaction.amount = "10.00"
    transaction.kind = "void"
    transaction.parent_id = 389404469
    transaction.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    response = ShopifyAPI::Transaction.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions/count.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions/389404469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"transaction" => {"id" => 389404469, "order_id" => 450789469, "kind" => "authorization", "gateway" => "bogus", "status" => "success", "message" => nil, "created_at" => "2005-08-01T11:57:11-04:00", "test" => false, "authorization" => "authorization-key", "location_id" => nil, "user_id" => nil, "parent_id" => nil, "processed_at" => "2005-08-01T11:57:11-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "web", "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil}, "receipt" => {"testcase" => true, "authorization" => "123456"}, "currency_exchange_adjustment" => nil, "amount" => "598.94", "currency" => "USD", "authorization_expires_at" => nil, "extended_authorization_attributes" => {}, "admin_graphql_api_id" => "gid://shopify/OrderTransaction/389404469"}}), headers: {})

    response = ShopifyAPI::Transaction.find(
      order_id: 450789469,
      id: 389404469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/transactions/389404469.json")

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
