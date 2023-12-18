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

class Giftcardadjustment202301Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"adjustments" => [{"id" => 1064273908, "gift_card_id" => 1035197676, "api_client_id" => nil, "user_id" => nil, "order_transaction_id" => nil, "number" => nil, "amount" => "10.00", "processed_at" => nil, "created_at" => "2023-11-02T13:38:57-04:00", "updated_at" => "2023-11-02T13:38:57-04:00", "note" => "Customer refilled gift card by $10", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}]}), headers: {})

    response = ShopifyAPI::Giftcardadjustment.adjustments(
      gift_card_id: 1035197676,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"adjustment" => {"amount" => 10.0, "remote_transaction_ref" => "gift_card_app_transaction_193402", "remote_transaction_url" => "http://example.com/my-gift-card-app/gift_card_adjustments/193402"}})
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 1064273910, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2023-11-02T13:44:04-04:00", "created_at" => "2023-11-02T13:44:04-04:00", "updated_at" => "2023-11-02T13:44:04-04:00", "note" => nil, "remote_transaction_ref" => "gift_card_app_transaction_193402", "remote_transaction_url" => "http://example.com/my-gift-card-app/gift_card_adjustments/193402"}}), headers: {})

    response = giftcardadjustment = ShopifyAPI::Giftcardadjustment.new
    giftcardadjustment.gift_card_id = 1035197676
    giftcardadjustment.adjustments(
      body: {"adjustment" => {"amount" => 10.0, "remote_transaction_ref" => "gift_card_app_transaction_193402", "remote_transaction_url" => "http://example.com/my-gift-card-app/gift_card_adjustments/193402"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"adjustment" => {"amount" => 10.0, "note" => "Customer refilled gift card by $10"}})
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 1064273909, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2023-11-02T13:44:02-04:00", "created_at" => "2023-11-02T13:44:02-04:00", "updated_at" => "2023-11-02T13:44:02-04:00", "note" => "Customer refilled gift card by $10", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    response = giftcardadjustment = ShopifyAPI::Giftcardadjustment.new
    giftcardadjustment.gift_card_id = 1035197676
    giftcardadjustment.adjustments(
      body: {"adjustment" => {"amount" => 10.0, "note" => "Customer refilled gift card by $10"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"adjustment" => {"amount" => -20.0, "note" => "Customer spent $20 via external service"}})
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 1064273912, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "-20.00", "processed_at" => "2023-11-02T13:44:05-04:00", "created_at" => "2023-11-02T13:44:05-04:00", "updated_at" => "2023-11-02T13:44:05-04:00", "note" => "Customer spent $20 via external service", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    response = giftcardadjustment = ShopifyAPI::Giftcardadjustment.new
    giftcardadjustment.gift_card_id = 1035197676
    giftcardadjustment.adjustments(
      body: {"adjustment" => {"amount" => -20.0, "note" => "Customer spent $20 via external service"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"adjustment" => {"amount" => 10.0, "processed_at" => "2023-05-02T13:44:04-04:00"}})
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 1064273911, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2023-05-02T13:44:04-04:00", "created_at" => "2023-11-02T13:44:04-04:00", "updated_at" => "2023-11-02T13:44:04-04:00", "note" => nil, "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    response = giftcardadjustment = ShopifyAPI::Giftcardadjustment.new
    giftcardadjustment.gift_card_id = 1035197676
    giftcardadjustment.adjustments(
      body: {"adjustment" => {"amount" => 10.0, "processed_at" => "2023-05-02T13:44:04-04:00"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments/1064273908.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 1064273908, "gift_card_id" => 1035197676, "api_client_id" => nil, "user_id" => nil, "order_transaction_id" => nil, "number" => nil, "amount" => "10.00", "processed_at" => nil, "created_at" => "2023-11-02T13:38:57-04:00", "updated_at" => "2023-11-02T13:38:57-04:00", "note" => "Customer refilled gift card by $10", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    response = ShopifyAPI::Giftcardadjustment.get_all(
      gift_card_id: 1035197676,
      adjustment_id: 1064273908,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/gift_cards/1035197676/adjustments/1064273908.json")

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
