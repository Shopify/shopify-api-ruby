# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class GiftCardAdjustment202107Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"adjustments" => [{"id" => 8, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2022-02-03T16:57:27-05:00", "created_at" => "2022-02-03T16:57:27-05:00", "updated_at" => "2022-02-03T16:57:27-05:00", "note" => "Customer refilled gift card by $10", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}]}), headers: {})

    ShopifyAPI::GiftCardAdjustment.all(
      gift_card_id: 1035197676,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "adjustment" => hash_including({"amount" => 10.0, "note" => "Customer refilled gift card by $10"}) }
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 10, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2022-02-03T16:57:31-05:00", "created_at" => "2022-02-03T16:57:31-05:00", "updated_at" => "2022-02-03T16:57:31-05:00", "note" => "Customer refilled gift card by $10", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    gift_card_adjustment = ShopifyAPI::GiftCardAdjustment.new
    gift_card_adjustment.gift_card_id = 1035197676
    gift_card_adjustment.amount = 10.0
    gift_card_adjustment.note = "Customer refilled gift card by $10"
    gift_card_adjustment.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "adjustment" => hash_including({"amount" => -20.0, "note" => "Customer spent $20 via external service"}) }
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 11, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "-20.00", "processed_at" => "2022-02-03T16:57:33-05:00", "created_at" => "2022-02-03T16:57:33-05:00", "updated_at" => "2022-02-03T16:57:33-05:00", "note" => "Customer spent $20 via external service", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    gift_card_adjustment = ShopifyAPI::GiftCardAdjustment.new
    gift_card_adjustment.gift_card_id = 1035197676
    gift_card_adjustment.amount = -20.0
    gift_card_adjustment.note = "Customer spent $20 via external service"
    gift_card_adjustment.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "adjustment" => hash_including({"amount" => 10.0, "remote_transaction_ref" => "gift_card_app_transaction_193402", "remote_transaction_url" => "http://example.com/my-gift-card-app/gift_card_adjustments/193402"}) }
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 12, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2022-02-03T16:57:34-05:00", "created_at" => "2022-02-03T16:57:34-05:00", "updated_at" => "2022-02-03T16:57:34-05:00", "note" => nil, "remote_transaction_ref" => "gift_card_app_transaction_193402", "remote_transaction_url" => "http://example.com/my-gift-card-app/gift_card_adjustments/193402"}}), headers: {})

    gift_card_adjustment = ShopifyAPI::GiftCardAdjustment.new
    gift_card_adjustment.gift_card_id = 1035197676
    gift_card_adjustment.amount = 10.0
    gift_card_adjustment.remote_transaction_ref = "gift_card_app_transaction_193402"
    gift_card_adjustment.remote_transaction_url = "http://example.com/my-gift-card-app/gift_card_adjustments/193402"
    gift_card_adjustment.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "adjustment" => hash_including({"amount" => 10.0, "processed_at" => "2021-08-03T16:57:35-04:00"}) }
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 13, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2021-08-03T16:57:35-04:00", "created_at" => "2022-02-03T16:57:35-05:00", "updated_at" => "2022-02-03T16:57:35-05:00", "note" => nil, "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    gift_card_adjustment = ShopifyAPI::GiftCardAdjustment.new
    gift_card_adjustment.gift_card_id = 1035197676
    gift_card_adjustment.amount = 10.0
    gift_card_adjustment.processed_at = "2021-08-03T16:57:35-04:00"
    gift_card_adjustment.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments/9.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"adjustment" => {"id" => 9, "gift_card_id" => 1035197676, "api_client_id" => 755357713, "user_id" => nil, "order_transaction_id" => nil, "number" => 1, "amount" => "10.00", "processed_at" => "2022-02-03T16:57:29-05:00", "created_at" => "2022-02-03T16:57:29-05:00", "updated_at" => "2022-02-03T16:57:29-05:00", "note" => "Customer refilled gift card by $10", "remote_transaction_ref" => nil, "remote_transaction_url" => nil}}), headers: {})

    ShopifyAPI::GiftCardAdjustment.find(
      gift_card_id: 1035197676,
      id: 9,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/gift_cards/1035197676/adjustments/9.json")
  end

end
