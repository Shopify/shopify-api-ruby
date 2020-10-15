require 'test_helper'

class MarketingEventTest < Test::Unit::TestCase

  def test_get_marketing_events
    fake("marketing_events", method: :get, body: load_fixture('marketing_events'))
    marketing_events = ShopifyAPI::MarketingEvent.all
    assert_equal(2, marketing_events.size)
  end

  def test_get_marketing_event
    fake("marketing_events/1", method: :get, body: load_fixture('marketing_event'))
    marketing_event = ShopifyAPI::MarketingEvent.find(1)
    assert_equal(1, marketing_event.id)
  end

  def test_create_marketing_event
    fake("marketing_events", method: :post, body: load_fixture('marketing_event'))
    marketing_event = ShopifyAPI::MarketingEvent.new
    marketing_event.currency_code = 'GBP'
    marketing_event.event_target = 'facebook'
    marketing_event.event_type = 'post'
    marketing_event.save

    assert_equal('facebook', marketing_event.event_target)
    assert_equal(1, marketing_event.id)
  end

  def test_delete_marketing_event
    fake("marketing_events/1", method: :get, body: load_fixture('marketing_event'))
    fake("marketing_events/1", method: :delete, body: "destroyed")
    marketing_event = ShopifyAPI::MarketingEvent.find(1)
    assert(marketing_event.destroy)
  end

  def test_update_marketing_event
    fake('marketing_events/1', method: :get, status: 200, body: load_fixture('marketing_event'))
    marketing_event = ShopifyAPI::MarketingEvent.find(1)
    marketing_event.currency = 'USD'
    fake('marketing_events/1', method: :put, status: 200, body: load_fixture('marketing_event'))
    assert(marketing_event.save)
  end

  def test_count_marketing_events
    fake("marketing_events/count", method: :get, body: '{"count": 2}')
    marketing_events_count = ShopifyAPI::MarketingEvent.count
    assert_equal(2, marketing_events_count)
  end

  def test_add_engagements
    fake("marketing_events/1", method: :get, body: load_fixture('marketing_event'))
    marketing_event = ShopifyAPI::MarketingEvent.find(1)
    fake("marketing_events/1/engagements", method: :post, status: 201, body: load_fixture('engagement'))
    engagement = {
      occurred_on: "2017-04-20",
      impressions_count: nil,
      views_count: nil,
      clicks_count: 10,
      shares_count: nil,
      favorites_count: nil,
      comments_count: nil,
      ad_spend: nil,
      is_cumulative: true
    }
    marketing_event.add_engagements(engagement)
    assert("2017-04-20", engagement[:occurred_on])
  end
end
