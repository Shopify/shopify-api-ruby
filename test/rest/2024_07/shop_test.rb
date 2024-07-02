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

class Shop202404Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2024-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/shop.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"shop" => {"id" => 548380009, "name" => "John Smith Test Store", "email" => "j.smith@example.com", "domain" => "shop.apple.com", "province" => "California", "country" => "US", "address1" => "1 Infinite Loop", "zip" => "95014", "city" => "Cupertino", "source" => nil, "phone" => "1231231234", "latitude" => 45.45, "longitude" => -75.43, "primary_locale" => "en", "address2" => "Suite 100", "created_at" => "2007-12-31T19:00:00-05:00", "updated_at" => "2024-07-02T09:00:54-05:00", "country_code" => "US", "country_name" => "United States", "currency" => "USD", "customer_email" => "customers@apple.com", "timezone" => "(GMT-05:00) Eastern Time (US & Canada)", "iana_timezone" => "America/New_York", "shop_owner" => "John Smith", "money_format" => "${{amount}}", "money_with_currency_format" => "${{amount}} USD", "weight_unit" => "lb", "province_code" => "CA", "taxes_included" => nil, "auto_configure_tax_inclusivity" => nil, "tax_shipping" => nil, "county_taxes" => true, "plan_display_name" => "Shopify Plus", "plan_name" => "enterprise", "has_discounts" => true, "has_gift_cards" => true, "myshopify_domain" => "jsmith.myshopify.com", "google_apps_domain" => nil, "google_apps_login_enabled" => nil, "money_in_emails_format" => "${{amount}}", "money_with_currency_in_emails_format" => "${{amount}} USD", "eligible_for_payments" => true, "requires_extra_payments_agreement" => false, "password_enabled" => false, "has_storefront" => true, "finances" => true, "primary_location_id" => 655441491, "checkout_api_supported" => true, "multi_location_enabled" => true, "setup_required" => false, "pre_launch_enabled" => false, "enabled_presentment_currencies" => ["USD"], "transactional_sms_disabled" => false, "marketing_sms_consent_enabled_at_checkout" => false}}), headers: {})

    response = ShopifyAPI::Shop.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/shop.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/shop.json?fields=address1%2Caddress2%2Ccity%2Cprovince%2Ccountry")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"shop" => {"province" => "California", "country" => "US", "address1" => "1 Infinite Loop", "city" => "Cupertino", "address2" => "Suite 100"}}), headers: {})

    response = ShopifyAPI::Shop.all(
      fields: "address1,address2,city,province,country",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/shop.json?fields=address1%2Caddress2%2Ccity%2Cprovince%2Ccountry")

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
