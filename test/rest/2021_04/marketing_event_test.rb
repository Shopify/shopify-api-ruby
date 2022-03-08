# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class MarketingEvent202104Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MarketingEvent.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "marketing_event" => hash_including({"started_at" => "2022-12-15", "utm_campaign" => "Christmas2022", "utm_source" => "facebook", "utm_medium" => "cpc", "event_type" => "ad", "referring_domain" => "facebook.com", "marketing_channel" => "social", "paid" => true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.started_at = "2022-12-15"
    marketing_event.utm_campaign = "Christmas2022"
    marketing_event.utm_source = "facebook"
    marketing_event.utm_medium = "cpc"
    marketing_event.event_type = "ad"
    marketing_event.referring_domain = "facebook.com"
    marketing_event.marketing_channel = "social"
    marketing_event.paid = true
    marketing_event.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MarketingEvent.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/count.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MarketingEvent.find(
      id: 998730532,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "marketing_event" => hash_including({"id" => 998730532, "remote_id" => "1000:2000", "started_at" => "2022-02-02T00:00  00:00", "ended_at" => "2022-02-03T00:00  00:00", "scheduled_to_end_at" => "2022-02-04T00:00  00:00", "budget" => "11.1", "budget_type" => "daily", "currency" => "CAD", "utm_campaign" => "other", "utm_source" => "other", "utm_medium" => "other", "event_type" => "ad", "referring_domain" => "instagram.com"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.id = 998730532
    marketing_event.remote_id = "1000:2000"
    marketing_event.started_at = "2022-02-02T00:00  00:00"
    marketing_event.ended_at = "2022-02-03T00:00  00:00"
    marketing_event.scheduled_to_end_at = "2022-02-04T00:00  00:00"
    marketing_event.budget = "11.1"
    marketing_event.budget_type = "daily"
    marketing_event.currency = "CAD"
    marketing_event.utm_campaign = "other"
    marketing_event.utm_source = "other"
    marketing_event.utm_medium = "other"
    marketing_event.event_type = "ad"
    marketing_event.referring_domain = "instagram.com"
    marketing_event.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MarketingEvent.delete(
      id: 998730532,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532/engagements.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"engagements" => [{"occurred_on" => "2022-01-15", "views_count" => 0, "clicks_count" => 0, "favorites_count" => 0, "ad_spend" => 10.0, "is_cumulative" => true}, {"occurred_on" => "2022-01-16", "views_count" => 100, "clicks_count" => 50, "is_cumulative" => true}, {"occurred_on" => "2022-01-17", "views_count" => 200, "clicks_count" => 100, "is_cumulative" => true}]})
      )
      .to_return(status: 200, body: "{}", headers: {})

    marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.id = 998730532
    marketing_event.engagements(
      body: {"engagements" => [{"occurred_on" => "2022-01-15", "views_count" => 0, "clicks_count" => 0, "favorites_count" => 0, "ad_spend" => 10.0, "is_cumulative" => true}, {"occurred_on" => "2022-01-16", "views_count" => 100, "clicks_count" => 50, "is_cumulative" => true}, {"occurred_on" => "2022-01-17", "views_count" => 200, "clicks_count" => 100, "is_cumulative" => true}]},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/marketing_events/998730532/engagements.json")
  end

end
