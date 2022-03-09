# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class GiftCard202201Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_cards" => [{"id" => 1035197676, "balance" => "100.00", "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "0d0d", "order_id" => nil}, {"id" => 766118925, "balance" => "25.00", "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => "2021-02-03", "template_suffix" => nil, "last_characters" => "0e0e", "order_id" => nil}, {"id" => 10274553, "balance" => "0.00", "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "0y0y", "order_id" => nil}]}), headers: {})

    ShopifyAPI::GiftCard.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json?status=enabled")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_cards" => [{"id" => 766118925, "balance" => "25.00", "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => "2021-02-03", "template_suffix" => nil, "last_characters" => "0e0e", "order_id" => nil}, {"id" => 10274553, "balance" => "0.00", "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "currency" => "USD", "initial_value" => "50.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "0y0y", "order_id" => nil}]}), headers: {})

    ShopifyAPI::GiftCard.all(
      status: "enabled",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json?status=enabled")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"note" => "This is a note", "initial_value" => 100.0, "code" => "ABCD EFGH IJKL MNOP", "template_suffix" => "gift_cards.birthday.liquid"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1063936322, "balance" => "100.00", "created_at" => "2022-02-03T17:25:46-05:00", "updated_at" => "2022-02-03T17:25:46-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => 755357713, "user_id" => nil, "customer_id" => nil, "note" => "This is a note", "expires_on" => nil, "template_suffix" => "gift_cards.birthday.liquid", "last_characters" => "mnop", "order_id" => nil, "code" => "abcdefghijklmnop"}}), headers: {})

    gift_card = ShopifyAPI::GiftCard.new
    gift_card.note = "This is a note"
    gift_card.initial_value = 100.0
    gift_card.code = "ABCD EFGH IJKL MNOP"
    gift_card.template_suffix = "gift_cards.birthday.liquid"
    gift_card.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"initial_value" => 25.0}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1063936323, "balance" => "25.00", "created_at" => "2022-02-03T17:25:47-05:00", "updated_at" => "2022-02-03T17:25:47-05:00", "currency" => "USD", "initial_value" => "25.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => 755357713, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "5f64", "order_id" => nil, "code" => "f48a7d8g64675f64"}}), headers: {})

    gift_card = ShopifyAPI::GiftCard.new
    gift_card.initial_value = 25.0
    gift_card.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"id" => 1035197676, "balance" => "100.00", "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "currency" => "USD", "initial_value" => "100.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    ShopifyAPI::GiftCard.find(
      id: 1035197676,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"id" => 1035197676, "note" => "Updating with a new note"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"note" => "Updating with a new note", "template_suffix" => nil, "initial_value" => "100.00", "balance" => "100.00", "customer_id" => nil, "id" => 1035197676, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:25:25-05:00", "currency" => "USD", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "expires_on" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    gift_card = ShopifyAPI::GiftCard.new
    gift_card.id = 1035197676
    gift_card.note = "Updating with a new note"
    gift_card.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"id" => 1035197676, "expires_on" => "2020-01-01"}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"expires_on" => "2020-01-01", "template_suffix" => nil, "initial_value" => "100.00", "balance" => "100.00", "customer_id" => nil, "id" => 1035197676, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:25:27-05:00", "currency" => "USD", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "note" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    gift_card = ShopifyAPI::GiftCard.new
    gift_card.id = 1035197676
    gift_card.expires_on = "2020-01-01"
    gift_card.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::GiftCard.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/count.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/count.json?status=enabled")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::GiftCard.count(
      status: "enabled",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/count.json?status=enabled")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676/disable.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "gift_card" => hash_including({"id" => 1035197676}) }
      )
      .to_return(status: 200, body: JSON.generate({"gift_card" => {"disabled_at" => "2022-02-03T17:25:28-05:00", "template_suffix" => nil, "initial_value" => "100.00", "balance" => "100.00", "customer_id" => nil, "id" => 1035197676, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:25:28-05:00", "currency" => "USD", "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "note" => nil, "expires_on" => nil, "last_characters" => "0d0d", "order_id" => nil}}), headers: {})

    gift_card = ShopifyAPI::GiftCard.new
    gift_card.id = 1035197676
    gift_card.disable(
      body: {"gift_card" => {"id" => 1035197676}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/1035197676/disable.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/search.json?query=last_characters%3Amnop")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"gift_cards" => [{"id" => 1063936321, "balance" => "10.00", "created_at" => "2022-02-03T17:25:32-05:00", "updated_at" => "2022-02-03T17:25:32-05:00", "currency" => "USD", "initial_value" => "10.00", "disabled_at" => nil, "line_item_id" => nil, "api_client_id" => nil, "user_id" => nil, "customer_id" => nil, "note" => nil, "expires_on" => nil, "template_suffix" => nil, "last_characters" => "mnop", "order_id" => nil}]}), headers: {})

    ShopifyAPI::GiftCard.search(
      query: "last_characters:mnop",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/search.json?query=last_characters%3Amnop")
  end

end
