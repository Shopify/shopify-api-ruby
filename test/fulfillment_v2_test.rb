require 'test_helper'

class FulfillmentV2Test < Test::Unit::TestCase
  context "FulfillmentV2" do
    context "#update_tracking" do
      should "be able to update tracking info for a fulfillment" do
        tracking_info = {
          number: 'JSDHFHAG',
          url: 'https://example.com/fulfillment_tracking/JSDHFHAG',
          company: 'ACME co',
        }
        fake_fulfillment = ActiveSupport::JSON.decode(load_fixture('fulfillment'))['fulfillment']
        fake_fulfillment['tracking_number'] = tracking_info[:number]
        fake_fulfillment['tracking_numbers'] = [tracking_info[:number]]
        fake_fulfillment['tracking_url'] = tracking_info[:url]
        fake_fulfillment['tracking_urls'] = [tracking_info[:url]]
        fake_fulfillment['tracking_company'] = tracking_info[:company]

        request_body = {
          fulfillment: {
            tracking_info: tracking_info,
            notify_customer: true
          }
        }
        fake "fulfillments/#{fake_fulfillment['id']}/update_tracking", method: :post,
          request_body: ActiveSupport::JSON.encode(request_body),
          body: ActiveSupport::JSON.encode(fulfillment: fake_fulfillment)

        fulfillment = ShopifyAPI::FulfillmentV2.new(id: fake_fulfillment['id'])
        assert fulfillment.update_tracking(tracking_info: tracking_info, notify_customer: true)

        assert_equal tracking_info[:number], fulfillment.tracking_number
        assert_equal [tracking_info[:number]], fulfillment.tracking_numbers
        assert_equal tracking_info[:url], fulfillment.tracking_url
        assert_equal [tracking_info[:url]], fulfillment.tracking_urls
        assert_equal tracking_info[:company], fulfillment.tracking_company
      end
    end
  end
end
