# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Fulfillment.all(
      session: @test_session,
      order_id: "450789469",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json?since_id=255858046")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Fulfillment.all(
      session: @test_session,
      order_id: "450789469",
      since_id: "255858046",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json?since_id=255858046")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 487838322, tracking_number: 123456789, tracking_urls: ["https://shipping.xyz/track.php?num=123456789", "https://anothershipper.corp/track.php?code=abc"], notify_customer: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 487838322
    fulfillment.tracking_number = 123456789
    fulfillment.tracking_urls = [
      "https://shipping.xyz/track.php?num=123456789",
      "https://anothershipper.corp/track.php?code=abc"
    ]
    fulfillment.notify_customer = true
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: nil, line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = nil
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_numbers: ["fcea06873c4ea1e98d61c3572167d39c", "a3db4d03b512ec06d395c0913f4c50fb", "43d33211f448bf539d9be158432454a2"], line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_numbers = [
      "fcea06873c4ea1e98d61c3572167d39c",
      "a3db4d03b512ec06d395c0913f4c50fb",
      "43d33211f448bf539d9be158432454a2"
    ]
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_url: "http://www.packagetrackr.com/track/somecarrier/1234567", tracking_company: "Jack Black's Pack, Stack and Track", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_url = "http://www.packagetrackr.com/track/somecarrier/1234567"
    fulfillment.tracking_company = "Jack Black's Pack, Stack and Track"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: 123456789, tracking_company: "4PX", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = 123456789
    fulfillment.tracking_company = "4PX"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: 123456789010, tracking_company: "fed ex", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = 123456789010
    fulfillment.tracking_company = "fed ex"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: 123456789010, tracking_company: "fed ex", tracking_url: "https://www.new-fedex-tracking.com/?number=123456789010", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = 123456789010
    fulfillment.tracking_company = "fed ex"
    fulfillment.tracking_url = "https://www.new-fedex-tracking.com/?number=123456789010"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: "RR123456789CN", tracking_company: "Chinese Post", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "RR123456789CN"
    fulfillment.tracking_company = "Chinese Post"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: 1234567, tracking_company: "Custom Tracking Company", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = 1234567
    fulfillment.tracking_company = "Custom Tracking Company"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: "CJ274101086US", tracking_url: "http://www.custom-tracking.com/?tracking_number=CJ274101086US", line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "CJ274101086US"
    fulfillment.tracking_url = "http://www.custom-tracking.com/?tracking_number=CJ274101086US"
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: nil, line_items: [{id: 518995019}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = nil
    fulfillment.line_items = [
      {
        id: 518995019
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({location_id: 655441491, tracking_number: nil, line_items: [{id: 518995019, quantity: 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = nil
    fulfillment.line_items = [
      {
        id: 518995019,
        quantity: 1
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000798/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Fulfillment.all(
      session: @test_session,
      fulfillment_order_id: "1046000798",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000798/fulfillments.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/count.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Fulfillment.count(
      session: @test_session,
      order_id: "450789469",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/count.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Fulfillment.find(
      session: @test_session,
      order_id: "450789469",
      id: "255858046",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({tracking_number: 987654321, id: 255858046}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.tracking_number = 987654321
    fulfillment.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({message: "The package was shipped this morning.", notify_customer: false, tracking_info: {number: 1562678, url: "https://www.my-shipping-company.com", company: "my-shipping-company"}, line_items_by_fulfillment_order: [{fulfillment_order_id: 1046000812, fulfillment_order_line_items: [{id: 1058737538, quantity: 1}]}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      number: 1562678,
      url: "https://www.my-shipping-company.com",
      company: "my-shipping-company"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        fulfillment_order_id: 1046000812,
        fulfillment_order_line_items: [
            {
                  id: 1058737538,
                  quantity: 1
                }
          ]
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments.json")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({message: "The package was shipped this morning.", notify_customer: false, tracking_info: {number: 1562678, url: "https://www.my-shipping-company.com", company: "my-shipping-company"}, line_items_by_fulfillment_order: [{fulfillment_order_id: 1046000813}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      number: 1562678,
      url: "https://www.my-shipping-company.com",
      company: "my-shipping-company"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        fulfillment_order_id: 1046000813
      }
    ]
    fulfillment.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments.json")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments/1069019883/update_tracking.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({notify_customer: true, tracking_info: {number: 1111, url: "http://www.my-url.com", company: "my-company"}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.id = 1069019883
    fulfillment.update_tracking(
      body: {fulfillment: {notify_customer: true, tracking_info: {number: 1111, url: "http://www.my-url.com", company: "my-company"}}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments/1069019883/update_tracking.json")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046/complete.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.complete(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046/complete.json")
  end

  sig do
    void
  end
  def test_23()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046/open.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.open(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046/open.json")
  end

  sig do
    void
  end
  def test_24()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046/cancel.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.cancel(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillments/255858046/cancel.json")
  end

  sig do
    void
  end
  def test_25()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments/1069019884/cancel.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new(session: @test_session)
    fulfillment.id = 1069019884
    fulfillment.cancel(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/fulfillments/1069019884/cancel.json")
  end

end
