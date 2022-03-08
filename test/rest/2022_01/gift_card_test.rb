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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::GiftCard.search(
      query: "last_characters:mnop",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/gift_cards/search.json?query=last_characters%3Amnop")
  end

end
