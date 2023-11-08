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

class Event202304Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 164748010, "subject_id" => 450789469, "created_at" => "2008-01-10T06:00:00-05:00", "subject_type" => "Order", "verb" => "confirmed", "arguments" => ["#1001", "Bob Norman"], "body" => nil, "message" => "Received new order <a href=\"https://jsmith.myshopify.com/admin/orders/450789469\">#1001</a> by Bob Norman.", "author" => "Shopify", "description" => "Received new order #1001 by Bob Norman.", "path" => "/admin/orders/450789469"}, {"id" => 365755215, "subject_id" => 632910392, "created_at" => "2008-01-10T07:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Nano - 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/632910392\">IPod Nano - 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Nano - 8GB.", "path" => "/admin/products/632910392"}, {"id" => 677313116, "subject_id" => 921728736, "created_at" => "2008-01-10T08:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Touch 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/921728736\">IPod Touch 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Touch 8GB.", "path" => "/admin/products/921728736"}]}), headers: {})

    response = ShopifyAPI::Event.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 103105390, "subject_id" => 450789469, "created_at" => "2008-01-10T05:00:00-05:00", "subject_type" => "Order", "verb" => "authorization_success", "arguments" => ["389404469", "210.94", "USD"], "body" => nil, "message" => "A transaction was authorized.", "author" => "Shopify", "description" => "A transaction was authorized.", "path" => "/admin/orders/450789469"}, {"id" => 164748010, "subject_id" => 450789469, "created_at" => "2008-01-10T06:00:00-05:00", "subject_type" => "Order", "verb" => "confirmed", "arguments" => ["#1001", "Bob Norman"], "body" => nil, "message" => "Received new order <a href=\"https://jsmith.myshopify.com/admin/orders/450789469\">#1001</a> by Bob Norman.", "author" => "Shopify", "description" => "Received new order #1001 by Bob Norman.", "path" => "/admin/orders/450789469"}, {"id" => 852065041, "subject_id" => 450789469, "created_at" => "2008-01-10T09:00:00-05:00", "subject_type" => "Order", "verb" => "placed", "arguments" => [], "body" => nil, "message" => "This order was created for Bob Norman from draft order <a href=\"https://jsmith.myshopify.com/admin/draft_orders/72885271\">#D1</a>.", "author" => "Shopify", "description" => "This order was created for Bob Norman from draft order #D1.", "path" => "/admin/orders/450789469"}]}), headers: {})

    response = ShopifyAPI::Event.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/events.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?filter=Product%2COrder")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 164748010, "subject_id" => 450789469, "created_at" => "2008-01-10T06:00:00-05:00", "subject_type" => "Order", "verb" => "confirmed", "arguments" => ["#1001", "Bob Norman"], "body" => nil, "message" => "Received new order <a href=\"https://jsmith.myshopify.com/admin/orders/450789469\">#1001</a> by Bob Norman.", "author" => "Shopify", "description" => "Received new order #1001 by Bob Norman.", "path" => "/admin/orders/450789469"}, {"id" => 365755215, "subject_id" => 632910392, "created_at" => "2008-01-10T07:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Nano - 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/632910392\">IPod Nano - 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Nano - 8GB.", "path" => "/admin/products/632910392"}, {"id" => 677313116, "subject_id" => 921728736, "created_at" => "2008-01-10T08:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Touch 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/921728736\">IPod Touch 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Touch 8GB.", "path" => "/admin/products/921728736"}]}), headers: {})

    response = ShopifyAPI::Event.all(
      filter: "Product,Order",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?filter=Product%2COrder")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?filter=Product&verb=destroy")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => []}), headers: {})

    response = ShopifyAPI::Event.all(
      filter: "Product",
      verb: "destroy",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?filter=Product&verb=destroy")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?created_at_min=2008-01-10+12%3A30%3A00%2B00%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 677313116, "subject_id" => 921728736, "created_at" => "2008-01-10T08:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Touch 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/921728736\">IPod Touch 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Touch 8GB.", "path" => "/admin/products/921728736"}]}), headers: {})

    response = ShopifyAPI::Event.all(
      created_at_min: "2008-01-10 12:30:00+00:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?created_at_min=2008-01-10+12%3A30%3A00%2B00%3A00")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?since_id=164748010")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 365755215, "subject_id" => 632910392, "created_at" => "2008-01-10T07:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Nano - 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/632910392\">IPod Nano - 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Nano - 8GB.", "path" => "/admin/products/632910392"}, {"id" => 677313116, "subject_id" => 921728736, "created_at" => "2008-01-10T08:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Touch 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/921728736\">IPod Touch 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Touch 8GB.", "path" => "/admin/products/921728736"}]}), headers: {})

    response = ShopifyAPI::Event.all(
      since_id: "164748010",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events.json?since_id=164748010")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/products/921728736/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 677313116, "subject_id" => 921728736, "created_at" => "2008-01-10T08:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Touch 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/921728736\">IPod Touch 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Touch 8GB.", "path" => "/admin/products/921728736"}]}), headers: {})

    response = ShopifyAPI::Event.all(
      product_id: 921728736,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/products/921728736/events.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/events.json?limit=1&since_id=164748010")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"events" => [{"id" => 852065041, "subject_id" => 450789469, "created_at" => "2008-01-10T09:00:00-05:00", "subject_type" => "Order", "verb" => "placed", "arguments" => [], "body" => nil, "message" => "This order was created for Bob Norman from draft order <a href=\"https://jsmith.myshopify.com/admin/draft_orders/72885271\">#D1</a>.", "author" => "Shopify", "description" => "This order was created for Bob Norman from draft order #D1.", "path" => "/admin/orders/450789469"}]}), headers: {})

    response = ShopifyAPI::Event.all(
      order_id: 450789469,
      limit: "1",
      since_id: "164748010",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/orders/450789469/events.json?limit=1&since_id=164748010")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events/677313116.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"event" => {"id" => 677313116, "subject_id" => 921728736, "created_at" => "2008-01-10T08:00:00-05:00", "subject_type" => "Product", "verb" => "create", "arguments" => ["IPod Touch 8GB"], "body" => nil, "message" => "Product was created: <a href=\"https://jsmith.myshopify.com/admin/products/921728736\">IPod Touch 8GB</a>.", "author" => "Shopify", "description" => "Product was created: IPod Touch 8GB.", "path" => "/admin/products/921728736"}}), headers: {})

    response = ShopifyAPI::Event.find(
      id: 677313116,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events/677313116.json")

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
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    response = ShopifyAPI::Event.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events/count.json")

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
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events/count.json?created_at_min=2008-01-10T13%3A00%3A00%2B00%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Event.count(
      created_at_min: "2008-01-10T13:00:00+00:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/events/count.json?created_at_min=2008-01-10T13%3A00%3A00%2B00%3A00")

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
