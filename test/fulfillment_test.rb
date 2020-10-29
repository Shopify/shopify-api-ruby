require 'test_helper'
require 'fulfillment_order_test_helper'

class FulFillmentTest < Test::Unit::TestCase
  include FulfillmentOrderTestHelper

  def setup
    super
    fake("orders/450789469/fulfillments/255858046", method: :get, body: load_fixture('fulfillment'))
  end

  context "Fulfillment" do
    context "#complete" do
      should "be able to complete fulfillment" do
        fulfillment = ShopifyAPI::Fulfillment.find(255858046, params: { order_id: 450789469 })

        success = ActiveSupport::JSON.decode(load_fixture('fulfillment'))
        success['fulfillment']['status'] = 'success'
        fake(
          "orders/450789469/fulfillments/255858046/complete", method: :post, body: ActiveSupport::JSON.encode(success)
        )

        assert_equal('pending', fulfillment.status)
        assert(fulfillment.complete)
        assert_equal('success', fulfillment.status)
      end
    end

    context "#cancel" do
      should "be able to cancel fulfillment" do
        fulfillment = ShopifyAPI::Fulfillment.find(255858046, params: { order_id: 450789469 })

        cancelled = ActiveSupport::JSON.decode(load_fixture('fulfillment'))
        cancelled['fulfillment']['status'] = 'cancelled'
        fake(
          "orders/450789469/fulfillments/255858046/cancel", method: :post, body: ActiveSupport::JSON.encode(cancelled)
        )

        assert_equal('pending', fulfillment.status)
        assert(fulfillment.cancel)
        assert_equal('cancelled', fulfillment.status)
      end
    end

    context "#open" do
      should "be able to open a fulfillment" do
        fulfillment = ShopifyAPI::Fulfillment.find(255858046, params: { order_id: 450789469 })

        open_fulfillment = ActiveSupport::JSON.decode(load_fixture('fulfillment'))
        open_fulfillment['fulfillment']['status'] = 'open'
        fake(
          "orders/450789469/fulfillments/255858046/open",
          method: :post,
          body: ActiveSupport::JSON.encode(open_fulfillment)
        )

        assert_equal('pending', fulfillment.status)
        assert(fulfillment.open)
        assert_equal('open', fulfillment.status)
      end
    end

    context "#find" do
      should "be able to find fulfillment" do
        fulfillment = ShopifyAPI::Fulfillment.find(255858046, params: { order_id: 450789469 })
        assert_equal(255858046, fulfillment.id)
        assert_equal(450789469, fulfillment.order_id)
      end
    end

    context "#create" do
      should "create a fulfillment with line_items_by_fulfillment_order" do
        create_fulfillment_attributes = {
          message: "The message for this FO fulfillment",
          notify_customer: true,
          tracking_info: {
            number: "XSDFHYR23475",
            url: "https://tracking.example.com/XSDFHYR23475",
            company: "TFTC - the fulfillment/tracking company",
          },
          line_items_by_fulfillment_order: [
            {
              fulfillment_order_id: 3,
              fulfillment_order_line_items: [{ id: 2, quantity: 1 }],
            }
          ],
        }
        request_body = { fulfillment: create_fulfillment_attributes }
        response_body = { fulfillment: create_fulfillment_attributes.merge(id: 346743624) }
        url_prefix = url_prefix_for_activated_session_for('2020-01')
        fake(
          'fulfillments',
          url: "#{url_prefix}/fulfillments.json",
          method: :post,
          request_body: ActiveSupport::JSON.encode(request_body),
          body: ActiveSupport::JSON.encode(response_body)
        )
        fulfillment = ShopifyAPI::Fulfillment.create(create_fulfillment_attributes)
        assert(fulfillment.is_a?(ShopifyAPI::Fulfillment))
        assert(fulfillment.persisted?)
        assert_equal(346743624, fulfillment.id)
      end

      should "raise NotImplementedError when api_version is older than 2020-01" do
        create_fulfillment_attributes = {
          message: "The message for this FO fulfillment",
          notify_customer: true,
          tracking_info: {
            number: "XSDFHYR23475",
            url: "https://tracking.example.com/XSDFHYR23475",
            company: "TFTC - the fulfillment/tracking company",
          },
          line_items_by_fulfillment_order: [
            {
              fulfillment_order_id: 3,
              fulfillment_order_line_items: [{ id: 2, quantity: 1 }],
            }
          ],
        }
        request_body = { fulfillment: create_fulfillment_attributes }
        response_body = { fulfillment: create_fulfillment_attributes.merge(id: 346743624) }
        url_prefix = url_prefix_for_activated_session_for('2019-10')
        fake(
          'fulfillments',
          url: "#{url_prefix}/fulfillments.json",
          method: :post,
          request_body: ActiveSupport::JSON.encode(request_body),
          body: ActiveSupport::JSON.encode(response_body)
        )
        assert_raises(NotImplementedError) do
          ShopifyAPI::Fulfillment.create(create_fulfillment_attributes)
        end
      end
    end

    context "#save" do
      should "save a fulfillment with line_items_by_fulfillment_order" do
        create_fulfillment_attributes = {
          message: "The message for this FO fulfillment",
          notify_customer: true,
          tracking_info: {
            number: "XSDFHYR23475",
            url: "https://tracking.example.com/XSDFHYR23475",
            company: "TFTC - the fulfillment/tracking company",
          },
          line_items_by_fulfillment_order: [
            {
              fulfillment_order_id: 3,
              fulfillment_order_line_items: [{ id: 2, quantity: 1 }],
            }
          ],
        }
        request_body = { fulfillment: create_fulfillment_attributes }
        response_body = { fulfillment: create_fulfillment_attributes.merge(id: 346743624) }
        url_prefix = url_prefix_for_activated_session_for('2020-01')
        fake(
          'fulfillments',
          url: "#{url_prefix}/fulfillments.json",
          method: :post,
          request_body: ActiveSupport::JSON.encode(request_body),
          body: ActiveSupport::JSON.encode(response_body)
        )
        fulfillment = ShopifyAPI::Fulfillment.new(create_fulfillment_attributes)
        assert(fulfillment.save)
        assert(fulfillment.is_a?(ShopifyAPI::Fulfillment))
        assert(fulfillment.persisted?)
        assert_equal(346743624, fulfillment.id)
      end

      should "save a fulfillment without line_items_by_fulfillment_order" do
        order_id = 8
        create_fulfillment_attributes = {
          message: "The message for this FO fulfillment",
          notify_customer: true,
          tracking_info: {
            number: "XSDFHYR23475",
            url: "https://tracking.example.com/XSDFHYR23475",
            company: "TFTC - the fulfillment/tracking company",
          },
        }
        request_body = { fulfillment: create_fulfillment_attributes }
        response_body = { fulfillment: create_fulfillment_attributes.merge(id: 346743624) }
        fake(
          "orders/#{order_id}/fulfillments",
          method: :post,
          request_body: ActiveSupport::JSON.encode(request_body),
          body: ActiveSupport::JSON.encode(response_body)
        )
        fulfillment = ShopifyAPI::Fulfillment.new(create_fulfillment_attributes)
        fulfillment.prefix_options[:order_id] = order_id

        assert(fulfillment.save)
        assert(fulfillment.is_a?(ShopifyAPI::Fulfillment))
        assert(fulfillment.persisted?)
        assert_equal(346743624, fulfillment.id)
      end
    end

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
            notify_customer: true,
          },
        }
        url_prefix = url_prefix_for_activated_session_for('2020-01')
        fake(
          'fulfillments',
          url: "#{url_prefix}/fulfillments/#{fake_fulfillment['id']}/update_tracking.json",
          method: :post,
          request_body: ActiveSupport::JSON.encode(request_body),
          body: ActiveSupport::JSON.encode(fulfillment: fake_fulfillment)
        )
        fulfillment = ShopifyAPI::Fulfillment.new(id: fake_fulfillment['id'])
        assert(fulfillment.update_tracking(tracking_info: tracking_info, notify_customer: true))

        assert_equal(tracking_info[:number], fulfillment.tracking_number)
        assert_equal([tracking_info[:number]], fulfillment.tracking_numbers)
        assert_equal(tracking_info[:url], fulfillment.tracking_url)
        assert_equal([tracking_info[:url]], fulfillment.tracking_urls)
        assert_equal(tracking_info[:company], fulfillment.tracking_company)
      end
    end
  end
end
