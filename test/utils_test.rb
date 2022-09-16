# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class UtilsTest < Test::Unit::TestCase
    extend T::Sig

    def setup
      super

      test_session = ShopifyAPI::Auth::Session.new(
        id: "id",
        shop: "test-shop.myshopify.io",
        access_token: "this_is_a_test_token",
      )
      ShopifyAPI::Context.activate_session(test_session)
    end

    def teardown
      super

      ShopifyAPI::Context.deactivate_session
    end

    sig { void }
    def test_current_shop
      stub_request(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/shop.json")
        .with(
          headers: { "X-Shopify-Access-Token" => "this_is_a_test_token", "Accept" => "application/json" },
          body: {},
        )
        .to_return(status: 200, body: load_fixture("shop"), headers: {})

      current_shop = ShopifyAPI::Utils.current_shop()

      assert_requested(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/shop.json")
      assert_equal(548380009, T.must(current_shop).id)
      assert_equal("John Smith Test Store", T.must(current_shop).name)
      assert_equal("j.smith@example.com", T.must(current_shop).email)
      assert_equal("shop.apple.com", T.must(current_shop).domain)
      assert_equal("1 Infinite Loop", T.must(current_shop).address1)
      assert_equal("Suite 100", T.must(current_shop).address2)
      assert_equal("Cupertino", T.must(current_shop).city)
      assert_equal("California", T.must(current_shop).province)
      assert_equal("US", T.must(current_shop).country)
      assert_equal("95014", T.must(current_shop).zip)
    end

    sig { void }
    def test_current_shop_with_fields
      fields = "id,address1,address2,city,province,country"
      test_shop = JSON.parse(T.must(load_fixture("shop")))
      shop_with_fields_only = {
        "shop" => test_shop["shop"].select { |k, _v| fields.split(",").include?(k) },
      }

      stub_request(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/shop.json?fields=id%2Caddress1%2Caddress2%2Ccity%2Cprovince%2Ccountry")
        .with(
          headers: { "X-Shopify-Access-Token" => "this_is_a_test_token", "Accept" => "application/json" },
          body: {},
        )
        .to_return(status: 200, body: JSON.generate(shop_with_fields_only), headers: {})

      current_shop = ShopifyAPI::Utils.current_shop(fields: fields)

      assert_requested(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/shop.json?fields=id%2Caddress1%2Caddress2%2Ccity%2Cprovince%2Ccountry")
      assert_equal("1 Infinite Loop", T.must(current_shop).address1)
      assert_equal("Suite 100", T.must(current_shop).address2)
      assert_equal("Cupertino", T.must(current_shop).city)
      assert_equal("California", T.must(current_shop).province)
      assert_equal("US", T.must(current_shop).country)
    end

    sig { void }
    def test_current_shop_passed_session
      different_session = ShopifyAPI::Auth::Session.new(
        id: "id",
        shop: "not-a-test-shop.myshopify.io",
        access_token: "this_is_a_different_token",
      )

      stub_request(:get, "https://not-a-test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/shop.json")
        .with(
          headers: { "X-Shopify-Access-Token" => "this_is_a_different_token", "Accept" => "application/json" },
          body: {},
        )
        .to_return(status: 200, body: load_fixture("shop"), headers: {})

      current_shop = ShopifyAPI::Utils.current_shop(session: different_session)

      assert_requested(:get, "https://not-a-test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/shop.json")
      assert_equal(548380009, T.must(current_shop).id)
      assert_equal("John Smith Test Store", T.must(current_shop).name)
      assert_equal("j.smith@example.com", T.must(current_shop).email)
      assert_equal("shop.apple.com", T.must(current_shop).domain)
      assert_equal("1 Infinite Loop", T.must(current_shop).address1)
      assert_equal("Suite 100", T.must(current_shop).address2)
      assert_equal("Cupertino", T.must(current_shop).city)
      assert_equal("California", T.must(current_shop).province)
      assert_equal("US", T.must(current_shop).country)
      assert_equal("95014", T.must(current_shop).zip)
    end

    sig { void }
    def test_current_recurring_application_charge
      stub_request(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/recurring_application_charges.json")
        .with(
          headers: { "X-Shopify-Access-Token" => "this_is_a_test_token", "Accept" => "application/json" },
          body: {},
        )
        .to_return(status: 200, body: load_fixture("recurring_application_charges"), headers: {})

      current_recurring_application_charge = ShopifyAPI::Utils.current_recurring_application_charge()

      assert_requested(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/recurring_application_charges.json")
      assert_equal(455696194, T.must(current_recurring_application_charge).id)
    end

    sig { void }
    def test_current_recurring_application_charge_no_active
      recurring_application_charges = JSON.parse(T.must(load_fixture("recurring_application_charges")))

      no_active_recurring_application_charges = {
        "recurring_application_charges" =>
          recurring_application_charges["recurring_application_charges"].select { |c| c["status"] != "active" },
      }

      stub_request(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/recurring_application_charges.json")
        .with(
          headers: { "X-Shopify-Access-Token" => "this_is_a_test_token", "Accept" => "application/json" },
          body: {},
        )
        .to_return(status: 200, body: JSON.generate(no_active_recurring_application_charges), headers: {})

      current_recurring_application_charge = ShopifyAPI::Utils.current_recurring_application_charge()

      assert_requested(:get, "https://test-shop.myshopify.io/admin/api/#{ShopifyAPI::Context.api_version}/recurring_application_charges.json")
      assert_nil(current_recurring_application_charge)
    end
  end
end
