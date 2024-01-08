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

class Customer202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?ids=207119551%2C1073339469")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 1073339469, "email" => "steve.lastnameson@example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:37:55-04:00", "updated_at" => "2023-10-03T13:37:55-04:00", "first_name" => "Steve", "last_name" => "Lastnameson", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => "+15142546011", "addresses" => [{"id" => 1053317303, "customer_id" => 1073339469, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:37:55-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/1073339469", "default_address" => {"id" => 1053317303, "customer_id" => 1073339469, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}}, {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:37:39-04:00", "updated_at" => "2023-10-03T13:37:39-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:37:39-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.all(
      ids: "207119551,1073339469",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?ids=207119551%2C1073339469")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?since_id=207119551")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 1073339471, "email" => "steve.lastnameson@example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:41:37-04:00", "updated_at" => "2023-10-03T13:41:37-04:00", "first_name" => "Steve", "last_name" => "Lastnameson", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => "+15142546011", "addresses" => [{"id" => 1053317305, "customer_id" => 1073339471, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:41:37-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/1073339471", "default_address" => {"id" => 1053317305, "customer_id" => 1073339471, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.all(
      since_id: "207119551",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?since_id=207119551")

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
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?updated_at_min=2023-10-02+17%3A41%3A56")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:41:38-04:00", "updated_at" => "2023-10-03T13:41:38-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:41:38-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.all(
      updated_at_min: "2023-10-02 17:41:56",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?updated_at_min=2023-10-02+17%3A41%3A56")

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
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:35:01-04:00", "updated_at" => "2023-10-03T13:35:01-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:35:01-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")

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
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?fields=id%2Cemail%2Ctags")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "tags" => "L\u00E9on, No\u00EBl"}]}), headers: {})

    response = ShopifyAPI::Customer.all(
      fields: "id,email,tags",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json?fields=id%2Cemail%2Ctags")

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
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?query=email%3Abob.norman%40mail.example.com")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:39:47-04:00", "updated_at" => "2023-10-03T13:39:47-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:39:47-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.search(
      query: "email:bob.norman@mail.example.com",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?query=email%3Abob.norman%40mail.example.com")

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
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?fields=id%2C+email%2C+first_name%2C+last_name&query=last_name%3ANorman")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman"}]}), headers: {})

    response = ShopifyAPI::Customer.search(
      fields: "id, email, first_name, last_name",
      query: "last_name:Norman",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?fields=id%2C+email%2C+first_name%2C+last_name&query=last_name%3ANorman")

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
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?fields=id%2C+email%2C+first_name%2C+last_name%2C+tags&query=customer_tag%3ANew+Customer")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 1073339468, "email" => "isabella.garcia@example.com", "first_name" => "Isabella", "last_name" => "Garcia", "tags" => "New Customer"}]}), headers: {})

    response = ShopifyAPI::Customer.search(
      fields: "id, email, first_name, last_name, tags",
      query: "customer_tag:New Customer",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?fields=id%2C+email%2C+first_name%2C+last_name%2C+tags&query=customer_tag%3ANew+Customer")

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
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?query=first_name%3ABob+country%3AUnited+States")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:44:55-04:00", "updated_at" => "2023-10-03T13:44:55-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:44:55-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.search(
      query: "first_name:Bob country:United States",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?query=first_name%3ABob+country%3AUnited+States")

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
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?query=email%3A%2A%40mail.example.com")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:40:50-04:00", "updated_at" => "2023-10-03T13:40:50-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:40:50-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    response = ShopifyAPI::Customer.search(
      query: "email:*@mail.example.com",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?query=email%3A%2A%40mail.example.com")

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
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?fields=id%2C+email%2C+first_name%2C+last_name%2C+verified_email&query=verified_email%3Atrue")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 1073339475, "email" => "isabella.garcia@example.com", "first_name" => "Isabella", "last_name" => "Garcia", "verified_email" => true}, {"id" => 207119551, "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "verified_email" => true}]}), headers: {})

    response = ShopifyAPI::Customer.search(
      fields: "id, email, first_name, last_name, verified_email",
      query: "verified_email:true",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/search.json?fields=id%2C+email%2C+first_name%2C+last_name%2C+verified_email&query=verified_email%3Atrue")

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
  def test_12()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:37:56-04:00", "updated_at" => "2023-10-03T13:37:56-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:37:56-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}), headers: {})

    response = ShopifyAPI::Customer.find(
      id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")

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
  def test_13()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "id" => 207119551, "accepts_marketing" => false, "created_at" => "2023-10-03T13:43:00-04:00", "updated_at" => "2023-10-03T13:43:00-04:00", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:43:00-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    customer.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")

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
  def test_14()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"accepts_marketing" => true, "accepts_marketing_updated_at" => "2023-09-30T13:38:58-04:00", "marketing_opt_in_level" => "confirmed_opt_in"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => true, "created_at" => "2023-10-03T13:38:44-04:00", "updated_at" => "2023-10-03T13:38:59-04:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2023-09-30T13:38:58-04:00", "marketing_opt_in_level" => "confirmed_opt_in", "tax_exemptions" => [], "email_marketing_consent" => {"state" => "subscribed", "opt_in_level" => "confirmed_opt_in", "consent_updated_at" => "2023-09-30T13:38:58-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:38:44-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.accepts_marketing = true
    customer.accepts_marketing_updated_at = "2023-09-30T13:38:58-04:00"
    customer.marketing_opt_in_level = "confirmed_opt_in"
    customer.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")

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
  def test_15()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"tags" => "New Customer, Repeat Customer"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "id" => 207119551, "accepts_marketing" => false, "created_at" => "2023-10-03T13:40:35-04:00", "updated_at" => "2023-10-03T13:40:35-04:00", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "New Customer, Repeat Customer", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:40:35-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.tags = "New Customer, Repeat Customer"
    customer.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")

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
  def test_16()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"email" => "changed@example.com", "note" => "Customer is a great guy"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"email" => "changed@example.com", "note" => "Customer is a great guy", "first_name" => "Bob", "last_name" => "Norman", "id" => 207119551, "accepts_marketing" => false, "created_at" => "2023-10-03T13:35:17-04:00", "updated_at" => "2023-10-03T13:35:31-04:00", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:35:31-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:35:17-04:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.email = "changed@example.com"
    customer.note = "Customer is a great guy"
    customer.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")

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
  def test_17()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::Customer.delete(
      id: 207119551,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551.json")

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
  def test_18()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"first_name" => "Steve", "last_name" => "Lastnameson", "email" => "steve.lastnameson@example.com", "phone" => "+15142546011", "verified_email" => true, "addresses" => [{"address1" => "123 Oak St", "city" => "Ottawa", "province" => "ON", "phone" => "555-1212", "zip" => "123 ABC", "last_name" => "Lastnameson", "first_name" => "Mother", "country" => "CA"}], "password" => "newpass", "password_confirmation" => "newpass", "send_email_welcome" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"id" => 1073339467, "email" => "steve.lastnameson@example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:36:34-04:00", "updated_at" => "2023-10-03T13:36:34-04:00", "first_name" => "Steve", "last_name" => "Lastnameson", "orders_count" => 0, "state" => "enabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => "+15142546011", "addresses" => [{"id" => 1053317301, "customer_id" => 1073339467, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:36:34-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/1073339467", "default_address" => {"id" => 1053317301, "customer_id" => 1073339467, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = "+15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        "address1" => "123 Oak St",
        "city" => "Ottawa",
        "province" => "ON",
        "phone" => "555-1212",
        "zip" => "123 ABC",
        "last_name" => "Lastnameson",
        "first_name" => "Mother",
        "country" => "CA"
      }
    ]
    customer.password = "newpass"
    customer.password_confirmation = "newpass"
    customer.send_email_welcome = false
    customer.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")

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
  def test_19()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"first_name" => "Steve", "last_name" => "Lastnameson", "email" => "steve.lastnameson@example.com", "phone" => "+15142546011", "verified_email" => true, "addresses" => [{"address1" => "123 Oak St", "city" => "Ottawa", "province" => "ON", "phone" => "555-1212", "zip" => "123 ABC", "last_name" => "Lastnameson", "first_name" => "Mother", "country" => "CA"}], "send_email_invite" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"id" => 1073339472, "email" => "steve.lastnameson@example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:42:12-04:00", "updated_at" => "2023-10-03T13:42:12-04:00", "first_name" => "Steve", "last_name" => "Lastnameson", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => "+15142546011", "addresses" => [{"id" => 1053317306, "customer_id" => 1073339472, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:42:12-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/1073339472", "default_address" => {"id" => 1053317306, "customer_id" => 1073339472, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = "+15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        "address1" => "123 Oak St",
        "city" => "Ottawa",
        "province" => "ON",
        "phone" => "555-1212",
        "zip" => "123 ABC",
        "last_name" => "Lastnameson",
        "first_name" => "Mother",
        "country" => "CA"
      }
    ]
    customer.send_email_invite = true
    customer.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")

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
  def test_20()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"first_name" => "Steve", "last_name" => "Lastnameson", "email" => "steve.lastnameson@example.com", "phone" => "+15142546011", "verified_email" => true, "addresses" => [{"address1" => "123 Oak St", "city" => "Ottawa", "province" => "ON", "phone" => "555-1212", "zip" => "123 ABC", "last_name" => "Lastnameson", "first_name" => "Mother", "country" => "CA"}], "metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"id" => 1073339477, "email" => "steve.lastnameson@example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:45:57-04:00", "updated_at" => "2023-10-03T13:45:57-04:00", "first_name" => "Steve", "last_name" => "Lastnameson", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => "+15142546011", "addresses" => [{"id" => 1053317311, "customer_id" => 1073339477, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:45:57-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/1073339477", "default_address" => {"id" => 1053317311, "customer_id" => 1073339477, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = "+15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        "address1" => "123 Oak St",
        "city" => "Ottawa",
        "province" => "ON",
        "phone" => "555-1212",
        "zip" => "123 ABC",
        "last_name" => "Lastnameson",
        "first_name" => "Mother",
        "country" => "CA"
      }
    ]
    customer.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    customer.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")

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
  def test_21()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer" => hash_including({"first_name" => "Steve", "last_name" => "Lastnameson", "email" => "steve.lastnameson@example.com", "phone" => "+15142546011", "verified_email" => true, "addresses" => [{"address1" => "123 Oak St", "city" => "Ottawa", "province" => "ON", "phone" => "555-1212", "zip" => "123 ABC", "last_name" => "Lastnameson", "first_name" => "Mother", "country" => "CA"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer" => {"id" => 1073339465, "email" => "steve.lastnameson@example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:34:29-04:00", "updated_at" => "2023-10-03T13:34:29-04:00", "first_name" => "Steve", "last_name" => "Lastnameson", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => "+15142546011", "addresses" => [{"id" => 1053317299, "customer_id" => 1073339465, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}], "accepts_marketing_updated_at" => "2023-10-03T13:34:29-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/1073339465", "default_address" => {"id" => 1053317299, "customer_id" => 1073339465, "first_name" => "Mother", "last_name" => "Lastnameson", "company" => nil, "address1" => "123 Oak St", "address2" => nil, "city" => "Ottawa", "province" => "Ontario", "country" => "Canada", "zip" => "123 ABC", "phone" => "555-1212", "name" => "Mother Lastnameson", "province_code" => "ON", "country_code" => "CA", "country_name" => "Canada", "default" => true}}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.first_name = "Steve"
    customer.last_name = "Lastnameson"
    customer.email = "steve.lastnameson@example.com"
    customer.phone = "+15142546011"
    customer.verified_email = true
    customer.addresses = [
      {
        "address1" => "123 Oak St",
        "city" => "Ottawa",
        "province" => "ON",
        "phone" => "555-1212",
        "zip" => "123 ABC",
        "last_name" => "Lastnameson",
        "first_name" => "Mother",
        "country" => "CA"
      }
    ]
    customer.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers.json")

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
  def test_22()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/account_activation_url.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"account_activation_url" => "https://jsmith.myshopify.com/account/activate/207119551/9ff4f54367497b72b14c6ae63e1abcf5-1696354820"}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.account_activation_url

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/account_activation_url.json")

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
  def test_23()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/send_invite.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"customer_invite" => {"to" => "new_test_email@shopify.com", "from" => "j.limited@example.com", "bcc" => ["j.limited@example.com"], "subject" => "Welcome to my new shop", "custom_message" => "My awesome new store"}})
      )
      .to_return(status: 200, body: JSON.generate({"customer_invite" => {"to" => "new_test_email@shopify.com", "from" => "j.limited@example.com", "subject" => "Welcome to my new shop", "custom_message" => "My awesome new store", "bcc" => ["j.limited@example.com"]}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.send_invite(
      body: {"customer_invite" => {"to" => "new_test_email@shopify.com", "from" => "j.limited@example.com", "bcc" => ["j.limited@example.com"], "subject" => "Welcome to my new shop", "custom_message" => "My awesome new store"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/send_invite.json")

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
  def test_24()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/send_invite.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"customer_invite" => {}})
      )
      .to_return(status: 200, body: JSON.generate({"customer_invite" => {"to" => "bob.norman@mail.example.com", "from" => "j.smith@example.com", "subject" => "Customer account activation", "custom_message" => "", "bcc" => []}}), headers: {})

    response = customer = ShopifyAPI::Customer.new
    customer.id = 207119551
    customer.send_invite(
      body: {"customer_invite" => {}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/send_invite.json")

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
  def test_25()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Customer.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/count.json")

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
  def test_26()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/count.json?updated_at_min=2023-10-02+17%3A41%3A21")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Customer.count(
      updated_at_min: "2023-10-02 17:41:21",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/count.json?updated_at_min=2023-10-02+17%3A41%3A21")

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
  def test_27()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/count.json?created_at_min=2023-10-02+17%3A35%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Customer.count(
      created_at_min: "2023-10-02 17:35:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/count.json?created_at_min=2023-10-02+17%3A35%3A00")

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
  def test_28()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"orders" => [{"id" => 450789469, "admin_graphql_api_id" => "gid://shopify/Order/450789469", "app_id" => nil, "browser_ip" => "0.0.0.0", "buyer_accepts_marketing" => false, "cancel_reason" => nil, "cancelled_at" => nil, "cart_token" => "68778783ad298f1c80c3bafcddeea02f", "checkout_id" => 901414060, "checkout_token" => "bd5a8aa1ecd019dd3520ff791ee3a24c", "client_details" => {"accept_language" => nil, "browser_height" => nil, "browser_ip" => "0.0.0.0", "browser_width" => nil, "session_hash" => nil, "user_agent" => nil}, "closed_at" => nil, "confirmation_number" => nil, "confirmed" => true, "contact_email" => "bob.norman@mail.example.com", "created_at" => "2008-01-10T11:00:00-05:00", "currency" => "USD", "current_subtotal_price" => "195.67", "current_subtotal_price_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "current_total_additional_fees_set" => nil, "current_total_discounts" => "3.33", "current_total_discounts_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "current_total_duties_set" => nil, "current_total_price" => "199.65", "current_total_price_set" => {"shop_money" => {"amount" => "199.65", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.65", "currency_code" => "USD"}}, "current_total_tax" => "3.98", "current_total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "customer_locale" => nil, "device_id" => nil, "discount_codes" => [{"code" => "TENOFF", "amount" => "10.00", "type" => "fixed_amount"}], "email" => "bob.norman@mail.example.com", "estimated_taxes" => false, "financial_status" => "partially_refunded", "fulfillment_status" => nil, "landing_site" => "http://www.example.com?source=abc", "landing_site_ref" => "abc", "location_id" => nil, "merchant_of_record_app_id" => nil, "name" => "#1001", "note" => nil, "note_attributes" => [{"name" => "custom engraving", "value" => "Happy Birthday"}, {"name" => "colour", "value" => "green"}], "number" => 1, "order_number" => 1001, "order_status_url" => "https://jsmith.myshopify.com/548380009/orders/b1946ac92492d2347c6235b4d2611184/authenticate?key=imasecretipod", "original_total_additional_fees_set" => nil, "original_total_duties_set" => nil, "payment_gateway_names" => ["bogus"], "phone" => "+557734881234", "po_number" => "ABC123", "presentment_currency" => "USD", "processed_at" => "2008-01-10T11:00:00-05:00", "reference" => "fhwdgads", "referring_site" => "http://www.otherexample.com", "source_identifier" => "fhwdgads", "source_name" => "web", "source_url" => nil, "subtotal_price" => "597.00", "subtotal_price_set" => {"shop_money" => {"amount" => "597.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "597.00", "currency_code" => "USD"}}, "tags" => "", "tax_exempt" => false, "tax_lines" => [{"price" => "11.94", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "11.94", "currency_code" => "USD"}, "presentment_money" => {"amount" => "11.94", "currency_code" => "USD"}}, "channel_liable" => nil}], "taxes_included" => false, "test" => false, "token" => "b1946ac92492d2347c6235b4d2611184", "total_discounts" => "10.00", "total_discounts_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_line_items_price" => "597.00", "total_line_items_price_set" => {"shop_money" => {"amount" => "597.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "597.00", "currency_code" => "USD"}}, "total_outstanding" => "0.00", "total_price" => "598.94", "total_price_set" => {"shop_money" => {"amount" => "598.94", "currency_code" => "USD"}, "presentment_money" => {"amount" => "598.94", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_tax" => "11.94", "total_tax_set" => {"shop_money" => {"amount" => "11.94", "currency_code" => "USD"}, "presentment_money" => {"amount" => "11.94", "currency_code" => "USD"}}, "total_tip_received" => "0.00", "total_weight" => 0, "updated_at" => "2008-01-10T11:00:00-05:00", "user_id" => nil, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:42:12-04:00", "updated_at" => "2023-10-03T13:42:12-04:00", "first_name" => "Bob", "last_name" => "Norman", "state" => "disabled", "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "phone" => "+16136120707", "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:42:12-04:00", "consent_collected_from" => "OTHER"}, "tags" => "L\u00E9on, No\u00EBl", "currency" => "USD", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}, "discount_applications" => [{"target_type" => "line_item", "type" => "discount_code", "value" => "10.0", "value_type" => "fixed_amount", "allocation_method" => "across", "target_selection" => "all", "code" => "TENOFF"}], "fulfillments" => [{"id" => 255858046, "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046", "created_at" => "2023-10-03T13:42:12-04:00", "location_id" => 655441491, "name" => "#1001.0", "order_id" => 450789469, "origin_address" => {}, "receipt" => {"testcase" => true, "authorization" => "123456"}, "service" => "manual", "shipment_status" => nil, "status" => "failure", "tracking_company" => "USPS", "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "updated_at" => "2023-10-03T13:42:12-04:00", "line_items" => [{"id" => 466157049, "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - green", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 39072856, "variant_inventory_management" => "shopify", "variant_title" => "green", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.34", "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}, "discount_application_index" => 0}]}]}], "line_items" => [{"id" => 466157049, "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - green", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 39072856, "variant_inventory_management" => "shopify", "variant_title" => "green", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.34", "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}, "discount_application_index" => 0}]}, {"id" => 518995019, "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "fulfillable_quantity" => 1, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - red", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008RED", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 49148385, "variant_inventory_management" => "shopify", "variant_title" => "red", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.33", "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "discount_application_index" => 0}]}, {"id" => 703073504, "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - black", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008BLACK", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 457924702, "variant_inventory_management" => "shopify", "variant_title" => "black", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.33", "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "discount_application_index" => 0}]}], "payment_terms" => nil, "refunds" => [{"id" => 509562969, "admin_graphql_api_id" => "gid://shopify/Refund/509562969", "created_at" => "2023-10-03T13:42:12-04:00", "note" => "it broke during shipping", "order_id" => 450789469, "processed_at" => "2023-10-03T13:42:12-04:00", "restock" => true, "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "user_id" => 548380009, "order_adjustments" => [], "transactions" => [{"id" => 179259969, "admin_graphql_api_id" => "gid://shopify/OrderTransaction/179259969", "amount" => "209.00", "authorization" => "authorization-key", "created_at" => "2005-08-05T12:59:12-04:00", "currency" => "USD", "device_id" => nil, "error_code" => nil, "gateway" => "bogus", "kind" => "refund", "location_id" => nil, "message" => nil, "order_id" => 450789469, "parent_id" => 801038806, "payment_id" => "#1001.3", "processed_at" => "2005-08-05T12:59:12-04:00", "receipt" => {}, "source_name" => "web", "status" => "success", "test" => false, "user_id" => nil}], "refund_line_items" => [{"id" => 104689539, "line_item_id" => 703073504, "location_id" => 487838322, "quantity" => 1, "restock_type" => "legacy_restock", "subtotal" => 195.66, "subtotal_set" => {"shop_money" => {"amount" => "195.66", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.66", "currency_code" => "USD"}}, "total_tax" => 3.98, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 703073504, "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - black", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008BLACK", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 457924702, "variant_inventory_management" => "shopify", "variant_title" => "black", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.33", "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "discount_application_index" => 0}]}}, {"id" => 709875399, "line_item_id" => 466157049, "location_id" => 487838322, "quantity" => 1, "restock_type" => "legacy_restock", "subtotal" => 195.67, "subtotal_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "total_tax" => 3.98, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 466157049, "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - green", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 39072856, "variant_inventory_management" => "shopify", "variant_title" => "green", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.34", "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}, "discount_application_index" => 0}]}}], "duties" => [], "additional_fees" => []}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "shipping_lines" => [{"id" => 369256396, "carrier_identifier" => nil, "code" => "Free Shipping", "discounted_price" => "0.00", "discounted_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "phone" => nil, "price" => "0.00", "price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "requested_fulfillment_service_id" => nil, "source" => "shopify", "title" => "Free Shipping", "tax_lines" => [], "discount_allocations" => []}]}]}), headers: {})

    response = ShopifyAPI::Customer.orders(
      id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/orders.json")

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
  def test_29()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/orders.json?status=any")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"orders" => [{"id" => 450789469, "admin_graphql_api_id" => "gid://shopify/Order/450789469", "app_id" => nil, "browser_ip" => "0.0.0.0", "buyer_accepts_marketing" => false, "cancel_reason" => nil, "cancelled_at" => nil, "cart_token" => "68778783ad298f1c80c3bafcddeea02f", "checkout_id" => 901414060, "checkout_token" => "bd5a8aa1ecd019dd3520ff791ee3a24c", "client_details" => {"accept_language" => nil, "browser_height" => nil, "browser_ip" => "0.0.0.0", "browser_width" => nil, "session_hash" => nil, "user_agent" => nil}, "closed_at" => nil, "confirmation_number" => nil, "confirmed" => true, "contact_email" => "bob.norman@mail.example.com", "created_at" => "2008-01-10T11:00:00-05:00", "currency" => "USD", "current_subtotal_price" => "195.67", "current_subtotal_price_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "current_total_additional_fees_set" => nil, "current_total_discounts" => "3.33", "current_total_discounts_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "current_total_duties_set" => nil, "current_total_price" => "199.65", "current_total_price_set" => {"shop_money" => {"amount" => "199.65", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.65", "currency_code" => "USD"}}, "current_total_tax" => "3.98", "current_total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "customer_locale" => nil, "device_id" => nil, "discount_codes" => [{"code" => "TENOFF", "amount" => "10.00", "type" => "fixed_amount"}], "email" => "bob.norman@mail.example.com", "estimated_taxes" => false, "financial_status" => "partially_refunded", "fulfillment_status" => nil, "landing_site" => "http://www.example.com?source=abc", "landing_site_ref" => "abc", "location_id" => nil, "merchant_of_record_app_id" => nil, "name" => "#1001", "note" => nil, "note_attributes" => [{"name" => "custom engraving", "value" => "Happy Birthday"}, {"name" => "colour", "value" => "green"}], "number" => 1, "order_number" => 1001, "order_status_url" => "https://jsmith.myshopify.com/548380009/orders/b1946ac92492d2347c6235b4d2611184/authenticate?key=imasecretipod", "original_total_additional_fees_set" => nil, "original_total_duties_set" => nil, "payment_gateway_names" => ["bogus"], "phone" => "+557734881234", "po_number" => "ABC123", "presentment_currency" => "USD", "processed_at" => "2008-01-10T11:00:00-05:00", "reference" => "fhwdgads", "referring_site" => "http://www.otherexample.com", "source_identifier" => "fhwdgads", "source_name" => "web", "source_url" => nil, "subtotal_price" => "597.00", "subtotal_price_set" => {"shop_money" => {"amount" => "597.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "597.00", "currency_code" => "USD"}}, "tags" => "", "tax_exempt" => false, "tax_lines" => [{"price" => "11.94", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "11.94", "currency_code" => "USD"}, "presentment_money" => {"amount" => "11.94", "currency_code" => "USD"}}, "channel_liable" => nil}], "taxes_included" => false, "test" => false, "token" => "b1946ac92492d2347c6235b4d2611184", "total_discounts" => "10.00", "total_discounts_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_line_items_price" => "597.00", "total_line_items_price_set" => {"shop_money" => {"amount" => "597.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "597.00", "currency_code" => "USD"}}, "total_outstanding" => "0.00", "total_price" => "598.94", "total_price_set" => {"shop_money" => {"amount" => "598.94", "currency_code" => "USD"}, "presentment_money" => {"amount" => "598.94", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_tax" => "11.94", "total_tax_set" => {"shop_money" => {"amount" => "11.94", "currency_code" => "USD"}, "presentment_money" => {"amount" => "11.94", "currency_code" => "USD"}}, "total_tip_received" => "0.00", "total_weight" => 0, "updated_at" => "2008-01-10T11:00:00-05:00", "user_id" => nil, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-10-03T13:44:38-04:00", "updated_at" => "2023-10-03T13:44:38-04:00", "first_name" => "Bob", "last_name" => "Norman", "state" => "disabled", "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "phone" => "+16136120707", "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-10-03T13:44:38-04:00", "consent_collected_from" => "OTHER"}, "tags" => "L\u00E9on, No\u00EBl", "currency" => "USD", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}, "discount_applications" => [{"target_type" => "line_item", "type" => "discount_code", "value" => "10.0", "value_type" => "fixed_amount", "allocation_method" => "across", "target_selection" => "all", "code" => "TENOFF"}], "fulfillments" => [{"id" => 255858046, "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046", "created_at" => "2023-10-03T13:44:38-04:00", "location_id" => 655441491, "name" => "#1001.0", "order_id" => 450789469, "origin_address" => {}, "receipt" => {"testcase" => true, "authorization" => "123456"}, "service" => "manual", "shipment_status" => nil, "status" => "failure", "tracking_company" => "USPS", "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "updated_at" => "2023-10-03T13:44:38-04:00", "line_items" => [{"id" => 466157049, "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - green", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 39072856, "variant_inventory_management" => "shopify", "variant_title" => "green", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.34", "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}, "discount_application_index" => 0}]}]}], "line_items" => [{"id" => 466157049, "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - green", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 39072856, "variant_inventory_management" => "shopify", "variant_title" => "green", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.34", "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}, "discount_application_index" => 0}]}, {"id" => 518995019, "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "fulfillable_quantity" => 1, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - red", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008RED", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 49148385, "variant_inventory_management" => "shopify", "variant_title" => "red", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.33", "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "discount_application_index" => 0}]}, {"id" => 703073504, "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - black", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008BLACK", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 457924702, "variant_inventory_management" => "shopify", "variant_title" => "black", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.33", "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "discount_application_index" => 0}]}], "payment_terms" => nil, "refunds" => [{"id" => 509562969, "admin_graphql_api_id" => "gid://shopify/Refund/509562969", "created_at" => "2023-10-03T13:44:38-04:00", "note" => "it broke during shipping", "order_id" => 450789469, "processed_at" => "2023-10-03T13:44:38-04:00", "restock" => true, "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "user_id" => 548380009, "order_adjustments" => [], "transactions" => [{"id" => 179259969, "admin_graphql_api_id" => "gid://shopify/OrderTransaction/179259969", "amount" => "209.00", "authorization" => "authorization-key", "created_at" => "2005-08-05T12:59:12-04:00", "currency" => "USD", "device_id" => nil, "error_code" => nil, "gateway" => "bogus", "kind" => "refund", "location_id" => nil, "message" => nil, "order_id" => 450789469, "parent_id" => 801038806, "payment_id" => "#1001.3", "processed_at" => "2005-08-05T12:59:12-04:00", "receipt" => {}, "source_name" => "web", "status" => "success", "test" => false, "user_id" => nil}], "refund_line_items" => [{"id" => 104689539, "line_item_id" => 703073504, "location_id" => 487838322, "quantity" => 1, "restock_type" => "legacy_restock", "subtotal" => 195.66, "subtotal_set" => {"shop_money" => {"amount" => "195.66", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.66", "currency_code" => "USD"}}, "total_tax" => 3.98, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 703073504, "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - black", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008BLACK", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 457924702, "variant_inventory_management" => "shopify", "variant_title" => "black", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.33", "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}, "discount_application_index" => 0}]}}, {"id" => 709875399, "line_item_id" => 466157049, "location_id" => 487838322, "quantity" => 1, "restock_type" => "legacy_restock", "subtotal" => 195.67, "subtotal_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "total_tax" => 3.98, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 466157049, "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "fulfillable_quantity" => 0, "fulfillment_service" => "manual", "fulfillment_status" => nil, "gift_card" => false, "grams" => 200, "name" => "IPod Nano - 8gb - green", "price" => "199.00", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "product_exists" => true, "product_id" => 632910392, "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "quantity" => 1, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "taxable" => true, "title" => "IPod Nano - 8gb", "total_discount" => "0.00", "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "variant_id" => 39072856, "variant_inventory_management" => "shopify", "variant_title" => "green", "vendor" => nil, "tax_lines" => [{"channel_liable" => nil, "price" => "3.98", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "rate" => 0.06, "title" => "State Tax"}], "duties" => [], "discount_allocations" => [{"amount" => "3.34", "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}, "discount_application_index" => 0}]}}], "duties" => [], "additional_fees" => []}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "shipping_lines" => [{"id" => 369256396, "carrier_identifier" => nil, "code" => "Free Shipping", "discounted_price" => "0.00", "discounted_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "phone" => nil, "price" => "0.00", "price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "requested_fulfillment_service_id" => nil, "source" => "shopify", "title" => "Free Shipping", "tax_lines" => [], "discount_allocations" => []}]}]}), headers: {})

    response = ShopifyAPI::Customer.orders(
      id: 207119551,
      status: "any",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/orders.json?status=any")

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
