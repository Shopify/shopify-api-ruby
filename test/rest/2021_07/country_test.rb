# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Country202107Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"countries" => [{"id" => 879921427, "name" => "Canada", "code" => "CA", "tax_name" => "GST", "tax" => 0.05, "provinces" => [{"id" => 205434194, "country_id" => 879921427, "name" => "Alberta", "code" => "AB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 170405627, "country_id" => 879921427, "name" => "British Columbia", "code" => "BC", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 342345110, "country_id" => 879921427, "name" => "Manitoba", "code" => "MB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 92264567, "country_id" => 879921427, "name" => "New Brunswick", "code" => "NB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 243284171, "country_id" => 879921427, "name" => "Newfoundland", "code" => "NL", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 439598329, "country_id" => 879921427, "name" => "Northwest Territories", "code" => "NT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 448070559, "country_id" => 879921427, "name" => "Nova Scotia", "code" => "NS", "tax_name" => nil, "tax_type" => "harmonized", "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 670206421, "country_id" => 879921427, "name" => "Nunavut", "code" => "NU", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 702530425, "country_id" => 879921427, "name" => "Ontario", "code" => "ON", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 570891722, "country_id" => 879921427, "name" => "Prince Edward Island", "code" => "PE", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.1, "tax_percentage" => 10.0}, {"id" => 224293623, "country_id" => 879921427, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 473391800, "country_id" => 879921427, "name" => "Saskatchewan", "code" => "SK", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 1005264686, "country_id" => 879921427, "name" => "Yukon", "code" => "YT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}]}, {"id" => 359115488, "name" => "Colombia", "code" => "CO", "tax_name" => "VAT", "tax" => 0.15, "provinces" => []}, {"id" => 817138619, "name" => "United States", "code" => "US", "tax_name" => "Federal Tax", "tax" => 0.0, "provinces" => [{"id" => 952629862, "country_id" => 817138619, "name" => "California", "code" => "CA", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => 1039932365, "tax" => 0.05, "tax_percentage" => 5.0}, {"id" => 222234158, "country_id" => 817138619, "name" => "Kentucky", "code" => "KY", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => 1039932365, "tax" => 0.06, "tax_percentage" => 6.0}, {"id" => 9350860, "country_id" => 817138619, "name" => "Massachusetts", "code" => "MA", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.065, "tax_percentage" => 6.5}, {"id" => 696485510, "country_id" => 817138619, "name" => "Minnesota", "code" => "MN", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.065, "tax_percentage" => 6.5}, {"id" => 753050225, "country_id" => 817138619, "name" => "New Jersey", "code" => "NJ", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.06, "tax_percentage" => 6.0}, {"id" => 1013111685, "country_id" => 817138619, "name" => "New York", "code" => "NY", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.04, "tax_percentage" => 4.0}, {"id" => 915134533, "country_id" => 817138619, "name" => "Pennsylvania", "code" => "PA", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.05, "tax_percentage" => 5.0}, {"id" => 591478044, "country_id" => 817138619, "name" => "Rhode Island", "code" => "RI", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}]}]}), headers: {})

    ShopifyAPI::Country.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json?since_id=359115488")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"countries" => [{"id" => 817138619, "name" => "United States", "code" => "US", "tax_name" => "Federal Tax", "tax" => 0.0, "provinces" => [{"id" => 952629862, "country_id" => 817138619, "name" => "California", "code" => "CA", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => 1039932365, "tax" => 0.05, "tax_percentage" => 5.0}, {"id" => 222234158, "country_id" => 817138619, "name" => "Kentucky", "code" => "KY", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => 1039932365, "tax" => 0.06, "tax_percentage" => 6.0}, {"id" => 9350860, "country_id" => 817138619, "name" => "Massachusetts", "code" => "MA", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.065, "tax_percentage" => 6.5}, {"id" => 696485510, "country_id" => 817138619, "name" => "Minnesota", "code" => "MN", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.065, "tax_percentage" => 6.5}, {"id" => 753050225, "country_id" => 817138619, "name" => "New Jersey", "code" => "NJ", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.06, "tax_percentage" => 6.0}, {"id" => 1013111685, "country_id" => 817138619, "name" => "New York", "code" => "NY", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.04, "tax_percentage" => 4.0}, {"id" => 915134533, "country_id" => 817138619, "name" => "Pennsylvania", "code" => "PA", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.05, "tax_percentage" => 5.0}, {"id" => 591478044, "country_id" => 817138619, "name" => "Rhode Island", "code" => "RI", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}]}, {"id" => 879921427, "name" => "Canada", "code" => "CA", "tax_name" => "GST", "tax" => 0.05, "provinces" => [{"id" => 205434194, "country_id" => 879921427, "name" => "Alberta", "code" => "AB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 170405627, "country_id" => 879921427, "name" => "British Columbia", "code" => "BC", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 342345110, "country_id" => 879921427, "name" => "Manitoba", "code" => "MB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 92264567, "country_id" => 879921427, "name" => "New Brunswick", "code" => "NB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 243284171, "country_id" => 879921427, "name" => "Newfoundland", "code" => "NL", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 439598329, "country_id" => 879921427, "name" => "Northwest Territories", "code" => "NT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 448070559, "country_id" => 879921427, "name" => "Nova Scotia", "code" => "NS", "tax_name" => nil, "tax_type" => "harmonized", "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 670206421, "country_id" => 879921427, "name" => "Nunavut", "code" => "NU", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 702530425, "country_id" => 879921427, "name" => "Ontario", "code" => "ON", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 570891722, "country_id" => 879921427, "name" => "Prince Edward Island", "code" => "PE", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.1, "tax_percentage" => 10.0}, {"id" => 224293623, "country_id" => 879921427, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 473391800, "country_id" => 879921427, "name" => "Saskatchewan", "code" => "SK", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 1005264686, "country_id" => 879921427, "name" => "Yukon", "code" => "YT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}]}]}), headers: {})

    ShopifyAPI::Country.all(
      since_id: "359115488",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json?since_id=359115488")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({"code" => "FR"}) }
      )
      .to_return(status: 200, body: JSON.generate({"country" => {"id" => 1070231513, "name" => "France", "code" => "FR", "tax_name" => "TVA", "tax" => 0.2, "provinces" => []}}), headers: {})

    country = ShopifyAPI::Country.new
    country.code = "FR"
    country.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({"code" => "FR", "tax" => 0.2}) }
      )
      .to_return(status: 200, body: JSON.generate({"country" => {"id" => 1070231514, "name" => "France", "code" => "FR", "tax_name" => "TVA", "tax" => 0.2, "provinces" => []}}), headers: {})

    country = ShopifyAPI::Country.new
    country.code = "FR"
    country.tax = 0.2
    country.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::Country.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"country" => {"id" => 879921427, "name" => "Canada", "code" => "CA", "tax_name" => "GST", "tax" => 0.05, "provinces" => [{"id" => 205434194, "country_id" => 879921427, "name" => "Alberta", "code" => "AB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 170405627, "country_id" => 879921427, "name" => "British Columbia", "code" => "BC", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 342345110, "country_id" => 879921427, "name" => "Manitoba", "code" => "MB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 92264567, "country_id" => 879921427, "name" => "New Brunswick", "code" => "NB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 243284171, "country_id" => 879921427, "name" => "Newfoundland", "code" => "NL", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 439598329, "country_id" => 879921427, "name" => "Northwest Territories", "code" => "NT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 448070559, "country_id" => 879921427, "name" => "Nova Scotia", "code" => "NS", "tax_name" => nil, "tax_type" => "harmonized", "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 670206421, "country_id" => 879921427, "name" => "Nunavut", "code" => "NU", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 702530425, "country_id" => 879921427, "name" => "Ontario", "code" => "ON", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 570891722, "country_id" => 879921427, "name" => "Prince Edward Island", "code" => "PE", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.1, "tax_percentage" => 10.0}, {"id" => 224293623, "country_id" => 879921427, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 473391800, "country_id" => 879921427, "name" => "Saskatchewan", "code" => "SK", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 1005264686, "country_id" => 879921427, "name" => "Yukon", "code" => "YT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}]}}), headers: {})

    ShopifyAPI::Country.find(
      id: 879921427,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({"id" => 879921427, "tax" => 0.05}) }
      )
      .to_return(status: 200, body: JSON.generate({"country" => {"id" => 879921427, "name" => "Canada", "code" => "CA", "tax_name" => "GST", "tax" => 0.05, "provinces" => [{"country_id" => 879921427, "tax_name" => "Tax", "id" => 205434194, "name" => "Alberta", "code" => "AB", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 170405627, "name" => "British Columbia", "code" => "BC", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 342345110, "name" => "Manitoba", "code" => "MB", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 92264567, "name" => "New Brunswick", "code" => "NB", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 243284171, "name" => "Newfoundland", "code" => "NL", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 439598329, "name" => "Northwest Territories", "code" => "NT", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 448070559, "name" => "Nova Scotia", "code" => "NS", "tax_type" => "harmonized", "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 670206421, "name" => "Nunavut", "code" => "NU", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 702530425, "name" => "Ontario", "code" => "ON", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 570891722, "name" => "Prince Edward Island", "code" => "PE", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.1, "tax_percentage" => 10.0}, {"id" => 224293623, "country_id" => 879921427, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 473391800, "name" => "Saskatchewan", "code" => "SK", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"country_id" => 879921427, "tax_name" => "Tax", "id" => 1005264686, "name" => "Yukon", "code" => "YT", "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}]}}), headers: {})

    country = ShopifyAPI::Country.new
    country.id = 879921427
    country.tax = 0.05
    country.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Country.delete(
      id: 879921427,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
  end

end
