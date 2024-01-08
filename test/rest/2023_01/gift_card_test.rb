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

class GiftCard202301Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json?status=enabled")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_cards" => [{"id" => 766118925, "balance" => "25.00", "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T08:59:11-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => "2023-01-02", "template_suffix" => nil, "recipient_id" => nil, "message" => nil, "send_on" => nil, "notify" => true, "last_characters" => "0e0e", "order_id" => nil}, {"id" => 10274553, "balance" => "0.00", "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T08:59:11-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "recipient_id" => nil, "message" => nil, "send_on" => nil, "notify" => true, "last_characters" => "0y0y", "order_id" => nil}]}), headers: {})

    response = ShopifyAPI::GiftCard.all(
      status: "enabled",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json?status=enabled")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_cards" => [{"id" => 1035197676, "balance" => "100.00", "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T08:59:11-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "recipient_id" => nil, "message" => nil, "send_on" => nil, "notify" => true, "last_characters" => "0d0d", "order_id" => nil}, {"id" => 766118925, "balance" => "25.00", "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T08:59:11-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => "2023-01-02", "template_suffix" => nil, "recipient_id" => nil, "message" => nil, "send_on" => nil, "notify" => true, "last_characters" => "0e0e", "order_id" => nil}, {"id" => 10274553, "balance" => "0.00", "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T08:59:11-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "recipient_id" => nil, "message" => nil, "send_on" => nil, "notify" => true, "last_characters" => "0y0y", "order_id" => nil}]}), headers: {})

    response = ShopifyAPI::GiftCard.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1035197676, "balance" => "100.00", "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T08:59:11-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    response = ShopifyAPI::GiftCard.find(
      id: 1035197676,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"expires_on" => "2020-01-01"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"expires_on" => "2020-01-01", "template_suffix" => nil, "initial_value" => "100.00", "balance" => "100.00", "customer_id" => nil, "id" => 1035197676, "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T09:01:27-05:00", "currency" => "USD", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "note" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    response = gift_card = ShopifyAPI::GiftCard.new
    gift_card.id = 1035197676
    gift_card.expires_on = "2020-01-01"
    gift_card.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"note" => "Updating with a new note"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"note" => "Updating with a new note", "template_suffix" => nil, "initial_value" => "100.00", "balance" => "100.00", "customer_id" => nil, "id" => 1035197676, "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T09:01:23-05:00", "currency" => "USD", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "expires_on" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    response = gift_card = ShopifyAPI::GiftCard.new
    gift_card.id = 1035197676
    gift_card.note = "Updating with a new note"
    gift_card.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    response = ShopifyAPI::GiftCard.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/count.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/count.json?status=enabled")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    response = ShopifyAPI::GiftCard.count(
      status: "enabled",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/count.json?status=enabled")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"note" => "This is a note", "initial_value" => "100.00", "code" => "ABCD EFGH IJKL MNOP", "template_suffix" => "gift_cards.birthday.liquid"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1063936318, "balance" => "100.00", "created_at" => "2024-01-02T09:01:24-05:00", "updated_at" => "2024-01-02T09:01:24-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => 755357713, "user_id" => nil, "customer_id" => nil, "note" => "This is a note", "expires_on" => nil, "template_suffix" => "gift_cards.birthday.liquid", "last_characters" => "mnop", "order_id" => nil, "code" => "abcdefghijklmnop"}}), headers: {})

    response = gift_card = ShopifyAPI::GiftCard.new
    gift_card.note = "This is a note"
    gift_card.initial_value = "100.00"
    gift_card.code = "ABCD EFGH IJKL MNOP"
    gift_card.template_suffix = "gift_cards.birthday.liquid"
    gift_card.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"initial_value" => "25.00"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1063936319, "balance" => "25.00", "created_at" => "2024-01-02T09:01:25-05:00", "updated_at" => "2024-01-02T09:01:25-05:00", "currency" => "USD", "initial_value" => "25.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => 755357713, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "bc76", "order_id" => nil, "code" => "ad62h8aae5c3bc76"}}), headers: {})

    response = gift_card = ShopifyAPI::GiftCard.new
    gift_card.initial_value = "25.00"
    gift_card.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"initial_value" => "100.00", "recipient_id" => 207119551, "message" => "Happy birthday!", "send_on" => "2023-12-31T19:00:00-05:00"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1063936320, "balance" => "100.00", "created_at" => "2024-01-02T09:01:26-05:00", "updated_at" => "2024-01-02T09:01:26-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => 755357713, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "6ag3", "order_id" => nil, "code" => "96577h3499436ag3"}}), headers: {})

    response = gift_card = ShopifyAPI::GiftCard.new
    gift_card.initial_value = "100.00"
    gift_card.recipient_id = 207119551
    gift_card.message = "Happy birthday!"
    gift_card.send_on = "2023-12-31T19:00:00-05:00"
    gift_card.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/disable.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"id" => 1035197676}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"disabled_at" => "2024-01-02T09:01:25-05:00", "template_suffix" => nil, "initial_value" => "100.00", "balance" => "100.00", "customer_id" => nil, "id" => 1035197676, "created_at" => "2024-01-02T08:59:11-05:00", "updated_at" => "2024-01-02T09:01:25-05:00", "currency" => "USD", "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "note" => nil, "expires_on" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    response = gift_card = ShopifyAPI::GiftCard.new
    gift_card.id = 1035197676
    gift_card.disable(
      body: {"gift_card" => {"id" => 1035197676}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/disable.json")

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
  def test_12()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/search.json?query=last_characters%3Amnop")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_cards" => [{"id" => 1063936321, "balance" => "10.00", "created_at" => "2024-01-02T09:01:29-05:00", "updated_at" => "2024-01-02T09:01:29-05:00", "currency" => "USD", "initial_value" => "10.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "recipient_id" => nil, "message" => nil, "send_on" => nil, "notify" => true, "last_characters" => "mnop", "order_id" => nil}]}), headers: {})

    response = ShopifyAPI::GiftCard.search(
      query: "last_characters:mnop",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/search.json?query=last_characters%3Amnop")

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
