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

class CustomerAddress202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}]}), headers: {})

    ShopifyAPI::CustomerAddress.all(
      customer_id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses.json?limit=1")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}]}), headers: {})

    ShopifyAPI::CustomerAddress.all(
      customer_id: 207119551,
      limit: "1",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses.json?limit=1")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "address" => hash_including({"address1" => "1 Rue des Carrieres", "address2" => "Suite 1234", "city" => "Montreal", "company" => "Fancy Co.", "first_name" => "Samuel", "last_name" => "de Champlain", "phone" => "819-555-5555", "province" => "Quebec", "country" => "Canada", "zip" => "G1R 4P5", "name" => "Samuel de Champlain", "province_code" => "QC", "country_code" => "CA", "country_name" => "Canada"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer_address" => {"id" => 1053317287, "customer_id" => 207119551, "first_name" => "Samuel", "last_name" => "de Champlain", "company" => "Fancy Co.", "address1" => "1 Rue des Carrieres", "address2" => "Suite 1234", "city" => "Montreal", "province" => "Quebec", "country" => "Canada", "zip" => "G1R 4P5", "phone" => "819-555-5555", "name" => "Samuel de Champlain", "province_code" => "QC", "country_code" => "CA", "country_name" => "Canada", "default" => false}}), headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new
    customer_address.customer_id = 207119551
    customer_address.address1 = "1 Rue des Carrieres"
    customer_address.address2 = "Suite 1234"
    customer_address.city = "Montreal"
    customer_address.company = "Fancy Co."
    customer_address.first_name = "Samuel"
    customer_address.last_name = "de Champlain"
    customer_address.phone = "819-555-5555"
    customer_address.province = "Quebec"
    customer_address.country = "Canada"
    customer_address.zip = "G1R 4P5"
    customer_address.name = "Samuel de Champlain"
    customer_address.province_code = "QC"
    customer_address.country_code = "CA"
    customer_address.country_name = "Canada"
    customer_address.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customer_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}), headers: {})

    ShopifyAPI::CustomerAddress.find(
      customer_id: 207119551,
      id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/207119551.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "address" => hash_including({"id" => 207119551, "zip" => "90210"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer_address" => {"customer_id" => 207119551, "zip" => "90210", "country" => "United States", "province" => "Kentucky", "city" => "Louisville", "address1" => "Chestnut Street 92", "address2" => "", "first_name" => nil, "last_name" => nil, "company" => nil, "phone" => "555-625-1199", "id" => 207119551, "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}), headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new
    customer_address.customer_id = 207119551
    customer_address.id = 207119551
    customer_address.zip = "90210"
    customer_address.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/207119551.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/1053317288.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::CustomerAddress.delete(
      customer_id: 207119551,
      id: 1053317288,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/1053317288.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/set.json?address_ids%5B%5D=1053317289&operation=destroy")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new
    customer_address.customer_id = 207119551
    customer_address.set(
      address_ids: ["1053317289"],
      operation: "destroy",
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/set.json?address_ids%5B%5D=1053317289&operation=destroy")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/1053317290/default.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customer_address" => {"id" => 1053317290, "customer_id" => 207119551, "first_name" => "Bob", "last_name" => "Norman", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "Bob Norman", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}), headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new
    customer_address.customer_id = 207119551
    customer_address.id = 1053317290
    customer_address.default()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customers/207119551/addresses/1053317290/default.json")
  end

end
