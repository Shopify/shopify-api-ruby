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

class MarketingEvent202301Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"marketing_events" => [{"id" => 998730532, "event_type" => "post", "remote_id" => "12345678", "started_at" => "2024-01-15T10:56:18-05:00", "ended_at" => nil, "scheduled_to_end_at" => nil, "budget" => "10.11", "currency" => "GBP", "manage_url" => nil, "preview_url" => nil, "utm_campaign" => "1234567890", "utm_source" => "facebook", "utm_medium" => "facebook-post", "budget_type" => "daily", "description" => nil, "marketing_channel" => "social", "paid" => false, "referring_domain" => "facebook.com", "breadcrumb_id" => nil, "marketing_activity_id" => nil, "admin_graphql_api_id" => "gid://shopify/MarketingEvent/998730532", "marketed_resources" => []}]}), headers: {})

    response = ShopifyAPI::MarketingEvent.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "marketing_event" => hash_including({"started_at" => "2024-12-15", "utm_campaign" => "Christmas2024", "utm_source" => "facebook", "utm_medium" => "cpc", "event_type" => "ad", "referring_domain" => "facebook.com", "marketing_channel" => "social", "paid" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"marketing_event" => {"id" => 1069063883, "event_type" => "ad", "remote_id" => nil, "started_at" => "2024-12-14T19:00:00-05:00", "ended_at" => nil, "scheduled_to_end_at" => nil, "budget" => nil, "currency" => nil, "manage_url" => nil, "preview_url" => nil, "utm_campaign" => "Christmas2024", "utm_source" => "facebook", "utm_medium" => "cpc", "budget_type" => nil, "description" => nil, "marketing_channel" => "social", "paid" => true, "referring_domain" => "facebook.com", "breadcrumb_id" => nil, "marketing_activity_id" => 1063897333, "admin_graphql_api_id" => "gid://shopify/MarketingEvent/1069063883", "marketed_resources" => []}}), headers: {})

    response = marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.started_at = "2024-12-15"
    marketing_event.utm_campaign = "Christmas2024"
    marketing_event.utm_source = "facebook"
    marketing_event.utm_medium = "cpc"
    marketing_event.event_type = "ad"
    marketing_event.referring_domain = "facebook.com"
    marketing_event.marketing_channel = "social"
    marketing_event.paid = true
    marketing_event.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::MarketingEvent.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/count.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"marketing_event" => {"id" => 998730532, "event_type" => "post", "remote_id" => "12345678", "started_at" => "2024-01-15T10:56:18-05:00", "ended_at" => nil, "scheduled_to_end_at" => nil, "budget" => "10.11", "currency" => "GBP", "manage_url" => nil, "preview_url" => nil, "utm_campaign" => "1234567890", "utm_source" => "facebook", "utm_medium" => "facebook-post", "budget_type" => "daily", "description" => nil, "marketing_channel" => "social", "paid" => false, "referring_domain" => "facebook.com", "breadcrumb_id" => nil, "marketing_activity_id" => nil, "admin_graphql_api_id" => "gid://shopify/MarketingEvent/998730532", "marketed_resources" => []}}), headers: {})

    response = ShopifyAPI::MarketingEvent.find(
      id: 998730532,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "marketing_event" => hash_including({"remote_id" => "1000:2000", "started_at" => "2024-02-02T00:00 +00:00", "ended_at" => "2024-02-03T00:00 +00:00", "scheduled_to_end_at" => "2024-02-04T00:00 +00:00", "budget" => "11.1", "budget_type" => "daily", "currency" => "CAD", "utm_campaign" => "other", "utm_source" => "other", "utm_medium" => "other", "event_type" => "ad", "referring_domain" => "instagram.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"marketing_event" => {"started_at" => "2024-02-01T19:00:00-05:00", "ended_at" => "2024-02-02T19:00:00-05:00", "scheduled_to_end_at" => "2024-02-03T19:00:00-05:00", "remote_id" => "1000:2000", "currency" => "CAD", "budget" => "11.1", "budget_type" => "daily", "id" => 998730532, "event_type" => "post", "manage_url" => nil, "preview_url" => nil, "utm_campaign" => "1234567890", "utm_source" => "facebook", "utm_medium" => "facebook-post", "description" => nil, "marketing_channel" => "social", "paid" => false, "referring_domain" => "facebook.com", "breadcrumb_id" => nil, "marketing_activity_id" => nil, "admin_graphql_api_id" => "gid://shopify/MarketingEvent/998730532", "marketed_resources" => []}}), headers: {})

    response = marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.id = 998730532
    marketing_event.remote_id = "1000:2000"
    marketing_event.started_at = "2024-02-02T00:00 +00:00"
    marketing_event.ended_at = "2024-02-03T00:00 +00:00"
    marketing_event.scheduled_to_end_at = "2024-02-04T00:00 +00:00"
    marketing_event.budget = "11.1"
    marketing_event.budget_type = "daily"
    marketing_event.currency = "CAD"
    marketing_event.utm_campaign = "other"
    marketing_event.utm_source = "other"
    marketing_event.utm_medium = "other"
    marketing_event.event_type = "ad"
    marketing_event.referring_domain = "instagram.com"
    marketing_event.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::MarketingEvent.delete(
      id: 998730532,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532/engagements.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"engagements" => [{"occurred_on" => "2024-01-15", "views_count" => 0, "clicks_count" => 0, "favorites_count" => 0, "ad_spend" => 10.0, "is_cumulative" => true}, {"occurred_on" => "2024-01-16", "views_count" => 100, "clicks_count" => 50, "is_cumulative" => true}, {"occurred_on" => "2024-01-17", "views_count" => 200, "clicks_count" => 100, "is_cumulative" => true}]})
      )
      .to_return(status: 200, body: JSON.generate({"engagements" => [{"occurred_on" => "2024-01-15", "fetched_at" => nil, "views_count" => 0, "impressions_count" => nil, "clicks_count" => 0, "favorites_count" => 0, "comments_count" => nil, "shares_count" => nil, "ad_spend" => "10.0", "currency_code" => nil, "is_cumulative" => true, "unsubscribes_count" => nil, "complaints_count" => nil, "fails_count" => nil, "sends_count" => nil, "unique_views_count" => nil, "unique_clicks_count" => nil, "utc_offset" => nil}, {"occurred_on" => "2024-01-16", "fetched_at" => nil, "views_count" => 100, "impressions_count" => nil, "clicks_count" => 50, "favorites_count" => nil, "comments_count" => nil, "shares_count" => nil, "ad_spend" => nil, "currency_code" => nil, "is_cumulative" => true, "unsubscribes_count" => nil, "complaints_count" => nil, "fails_count" => nil, "sends_count" => nil, "unique_views_count" => nil, "unique_clicks_count" => nil, "utc_offset" => nil}, {"occurred_on" => "2024-01-17", "fetched_at" => nil, "views_count" => 200, "impressions_count" => nil, "clicks_count" => 100, "favorites_count" => nil, "comments_count" => nil, "shares_count" => nil, "ad_spend" => nil, "currency_code" => nil, "is_cumulative" => true, "unsubscribes_count" => nil, "complaints_count" => nil, "fails_count" => nil, "sends_count" => nil, "unique_views_count" => nil, "unique_clicks_count" => nil, "utc_offset" => nil}]}), headers: {})

    response = marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.id = 998730532
    marketing_event.engagements(
      body: {"engagements" => [{"occurred_on" => "2024-01-15", "views_count" => 0, "clicks_count" => 0, "favorites_count" => 0, "ad_spend" => 10.0, "is_cumulative" => true}, {"occurred_on" => "2024-01-16", "views_count" => 100, "clicks_count" => 50, "is_cumulative" => true}, {"occurred_on" => "2024-01-17", "views_count" => 200, "clicks_count" => 100, "is_cumulative" => true}]},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/marketing_events/998730532/engagements.json")

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
