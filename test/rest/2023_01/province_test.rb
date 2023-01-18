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

class Province202301Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"provinces" => [{"id" => 205434194, "country_id" => 879921427, "name" => "Alberta", "code" => "AB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 170405627, "country_id" => 879921427, "name" => "British Columbia", "code" => "BC", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 342345110, "country_id" => 879921427, "name" => "Manitoba", "code" => "MB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.07, "tax_percentage" => 7.0}, {"id" => 92264567, "country_id" => 879921427, "name" => "New Brunswick", "code" => "NB", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 243284171, "country_id" => 879921427, "name" => "Newfoundland", "code" => "NL", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 439598329, "country_id" => 879921427, "name" => "Northwest Territories", "code" => "NT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 448070559, "country_id" => 879921427, "name" => "Nova Scotia", "code" => "NS", "tax_name" => nil, "tax_type" => "harmonized", "shipping_zone_id" => nil, "tax" => 0.15, "tax_percentage" => 15.0}, {"id" => 670206421, "country_id" => 879921427, "name" => "Nunavut", "code" => "NU", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 702530425, "country_id" => 879921427, "name" => "Ontario", "code" => "ON", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 570891722, "country_id" => 879921427, "name" => "Prince Edward Island", "code" => "PE", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.1, "tax_percentage" => 10.0}, {"id" => 224293623, "country_id" => 879921427, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 473391800, "country_id" => 879921427, "name" => "Saskatchewan", "code" => "SK", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}, {"id" => 1005264686, "country_id" => 879921427, "name" => "Yukon", "code" => "YT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}]}), headers: {})

    ShopifyAPI::Province.all(
      country_id: 879921427,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces.json?since_id=536137098")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"provinces" => [{"id" => 570891722, "country_id" => 879921427, "name" => "Prince Edward Island", "code" => "PE", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.1, "tax_percentage" => 10.0}, {"id" => 670206421, "country_id" => 879921427, "name" => "Nunavut", "code" => "NU", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}, {"id" => 702530425, "country_id" => 879921427, "name" => "Ontario", "code" => "ON", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.08, "tax_percentage" => 8.0}, {"id" => 1005264686, "country_id" => 879921427, "name" => "Yukon", "code" => "YT", "tax_name" => nil, "tax_type" => nil, "shipping_zone_id" => nil, "tax" => 0.0, "tax_percentage" => 0.0}]}), headers: {})

    ShopifyAPI::Province.all(
      country_id: 879921427,
      since_id: "536137098",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces.json?since_id=536137098")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 13}), headers: {})

    ShopifyAPI::Province.count(
      country_id: 879921427,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces/count.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces/224293623.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"province" => {"id" => 224293623, "country_id" => 879921427, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}}), headers: {})

    ShopifyAPI::Province.find(
      country_id: 879921427,
      id: 224293623,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces/224293623.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces/224293623.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "province" => hash_including({"tax" => 0.09}) }
      )
      .to_return(status: 200, body: JSON.generate({"province" => {"country_id" => 879921427, "id" => 224293623, "name" => "Quebec", "code" => "QC", "tax_name" => "HST", "tax_type" => "compounded", "shipping_zone_id" => nil, "tax" => 0.09, "tax_percentage" => 9.0}}), headers: {})

    province = ShopifyAPI::Province.new
    province.country_id = 879921427
    province.id = 224293623
    province.tax = 0.09
    province.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/countries/879921427/provinces/224293623.json")
  end

end
