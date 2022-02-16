# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Customer202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json?since_id=207119551")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.all(
      session: @test_session,
      since_id: "207119551",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json?since_id=207119551")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json?updated_at_min=2022-02-02+21%3A51%3A21")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.all(
      session: @test_session,
      updated_at_min: "2022-02-02 21:51:21",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json?updated_at_min=2022-02-02+21%3A51%3A21")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json?ids=207119551%2C1073339489")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.all(
      session: @test_session,
      ids: "207119551,1073339489",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json?ids=207119551%2C1073339489")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({first_name: "Steve", last_name: "Lastnameson", email: "steve.lastnameson@example.com", phone: " 15142546011", verified_email: true, addresses: [{address1: "123 Oak St", city: "Ottawa", province: "ON", phone: "555-1212", zip: "123 ABC", last_name: "Lastnameson", first_name: "Mother", country: "CA"}], password: "newpass", password_confirmation: "newpass", send_email_welcome: false}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = " 15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        address1: "123 Oak St",
        city: "Ottawa",
        province: "ON",
        phone: "555-1212",
        zip: "123 ABC",
        last_name: "Lastnameson",
        first_name: "Mother",
        country: "CA"
      }
    ]
    customer.password = "newpass"
    customer.password_confirmation = "newpass"
    customer.send_email_welcome = false
    customer.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({first_name: "Steve", last_name: "Lastnameson", email: "steve.lastnameson@example.com", phone: " 15142546011", verified_email: true, addresses: [{address1: "123 Oak St", city: "Ottawa", province: "ON", phone: "555-1212", zip: "123 ABC", last_name: "Lastnameson", first_name: "Mother", country: "CA"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = " 15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        address1: "123 Oak St",
        city: "Ottawa",
        province: "ON",
        phone: "555-1212",
        zip: "123 ABC",
        last_name: "Lastnameson",
        first_name: "Mother",
        country: "CA"
      }
    ]
    customer.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({first_name: "Steve", last_name: "Lastnameson", email: "steve.lastnameson@example.com", phone: " 15142546011", verified_email: true, addresses: [{address1: "123 Oak St", city: "Ottawa", province: "ON", phone: "555-1212", zip: "123 ABC", last_name: "Lastnameson", first_name: "Mother", country: "CA"}], metafields: [{key: "new", value: "newvalue", value_type: "string", namespace: "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = " 15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        address1: "123 Oak St",
        city: "Ottawa",
        province: "ON",
        phone: "555-1212",
        zip: "123 ABC",
        last_name: "Lastnameson",
        first_name: "Mother",
        country: "CA"
      }
    ]
    customer.metafields = [
      {
        key: "new",
        value: "newvalue",
        value_type: "string",
        namespace: "global"
      }
    ]
    customer.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({first_name: "Steve", last_name: "Lastnameson", email: "steve.lastnameson@example.com", phone: " 15142546011", verified_email: true, addresses: [{address1: "123 Oak St", city: "Ottawa", province: "ON", phone: "555-1212", zip: "123 ABC", last_name: "Lastnameson", first_name: "Mother", country: "CA"}], send_email_invite: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = " 15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        address1: "123 Oak St",
        city: "Ottawa",
        province: "ON",
        phone: "555-1212",
        zip: "123 ABC",
        last_name: "Lastnameson",
        first_name: "Mother",
        country: "CA"
      }
    ]
    customer.send_email_invite = true
    customer.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/search.json?query=Bob+country%3AUnited+States")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.search(
      session: @test_session,
      query: "Bob country:United States",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/search.json?query=Bob+country%3AUnited+States")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.find(
      session: @test_session,
      id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({id: 207119551, email: "changed@email.address.com", note: "Customer is a great guy"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.email = "changed@email.address.com"
    customer.note = "Customer is a great guy"
    customer.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({id: 207119551, metafields: [{key: "new", value: "newvalue", value_type: "string", namespace: "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.metafields = [
      {
        key: "new",
        value: "newvalue",
        value_type: "string",
        namespace: "global"
      }
    ]
    customer.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({id: 207119551, tags: "New Customer, Repeat Customer"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.tags = "New Customer, Repeat Customer"
    customer.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({id: 207119551, accepts_marketing: true, accepts_marketing_updated_at: "2022-01-31T16:45:55-05:00", marketing_opt_in_level: "confirmed_opt_in"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.accepts_marketing = true
    customer.accepts_marketing_updated_at = "2022-01-31T16:45:55-05:00"
    customer.marketing_opt_in_level = "confirmed_opt_in"
    customer.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/account_activation_url.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.account_activation_url()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/account_activation_url.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/send_invite.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({customer_invite: {}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.send_invite(
      body: {customer_invite: {}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/send_invite.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/send_invite.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({customer_invite: {to: "new_test_email@shopify.com", from: "j.limited@example.com", bcc: ["j.limited@example.com"], subject: "Welcome to my new shop", custom_message: "My awesome new store"}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer = ShopifyAPI::Customer.new(session: @test_session)
    customer.id = 207119551
    customer.send_invite(
      body: {customer_invite: {to: "new_test_email@shopify.com", from: "j.limited@example.com", bcc: ["j.limited@example.com"], subject: "Welcome to my new shop", custom_message: "My awesome new store"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/send_invite.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/count.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Customer.orders(
      session: @test_session,
      id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/orders.json")
  end

end
