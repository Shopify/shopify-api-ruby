# frozen_string_literal: true
require 'test_helper'
require 'fulfillment_order_test_helper'

class FulfillmentV2Test < Test::Unit::TestCase
  include FulfillmentOrderTestHelper

  def setup
    super
    @tracking_info = {
      number: 'JSDHFHAG',
      url: 'https://example.com/fulfillment_tracking/JSDHFHAG',
      company: 'ACME co',
    }
    @fake_fulfillment = ActiveSupport::JSON.decode(load_fixture('fulfillment'))['fulfillment']
    @fake_fulfillment['tracking_number'] = @tracking_info[:number]
    @fake_fulfillment['tracking_numbers'] = [@tracking_info[:number]]
    @fake_fulfillment['tracking_url'] = @tracking_info[:url]
    @fake_fulfillment['tracking_urls'] = [@tracking_info[:url]]
    @fake_fulfillment['tracking_company'] = @tracking_info[:company]

    @request_body = {
      fulfillment: {
        tracking_info: @tracking_info,
        notify_customer: true,
      },
    }
    @url_prefix = url_prefix_for_activated_session_for('2020-01')
    fake(
      'fulfillments',
      url: "#{@url_prefix}/fulfillments/#{@fake_fulfillment['id']}/update_tracking.json",
      method: :post,
      request_body: ActiveSupport::JSON.encode(@request_body),
      body: ActiveSupport::JSON.encode(fulfillment: @fake_fulfillment)
    )
  end

  context "FulfillmentV2" do
    context "#update_tracking" do
      should "be able to update tracking info for a fulfillment" do
        fulfillment = ShopifyAPI::FulfillmentV2.new(id: @fake_fulfillment['id'])
        assert(fulfillment.update_tracking(tracking_info: @tracking_info, notify_customer: true))

        assert_equal(@tracking_info[:number], fulfillment.tracking_number)
        assert_equal([@tracking_info[:number]], fulfillment.tracking_numbers)
        assert_equal(@tracking_info[:url], fulfillment.tracking_url)
        assert_equal([@tracking_info[:url]], fulfillment.tracking_urls)
        assert_equal(@tracking_info[:company], fulfillment.tracking_company)
      end

      should "raise NotImplementedError when api_version is older than 2020-01" do
        @url_prefix = url_prefix_for_activated_session_for('2019-10')
        fake(
          'fulfillments',
          url: "#{@url_prefix}/fulfillments/#{@fake_fulfillment['id']}/update_tracking.json",
          method: :post,
          request_body: ActiveSupport::JSON.encode(@request_body),
          body: ActiveSupport::JSON.encode(fulfillment: @fake_fulfillment)
        )
        assert_raises(NotImplementedError) do
          ShopifyAPI::FulfillmentV2.new(id: @fake_fulfillment['id'])
        end
      end
    end
  end
end
