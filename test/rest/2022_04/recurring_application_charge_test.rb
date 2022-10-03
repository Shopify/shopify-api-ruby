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

class RecurringApplicationCharge202204Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266947, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-10-03T12:52:52-04:00", "updated_at" => "2022-10-03T12:52:52-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266947", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266947/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBANeWT06EmF1dG9fYWN0aXZhdGVU--fd1fceece89091b9d39f3c13b2b6ba1868c07823"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266950, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-10-03T12:52:58-04:00", "updated_at" => "2022-10-03T12:52:58-04:00", "test" => true, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266950", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266950/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAZeWT06EmF1dG9fYWN0aXZhdGVU--c5d071902db4f2e27dd740432882625a5fab74c9"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.test = true
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "capped_amount" => 100, "terms" => "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266951, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-10-03T12:52:59-04:00", "updated_at" => "2022-10-03T12:52:59-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "trial_ends_on" => nil, "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266951", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266951/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAdeWT06EmF1dG9fYWN0aXZhdGVU--c1960487d59ce5a37a7ff2dfa85ca64c904b92cd"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "trial_days" => 5}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266954, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-10-03T12:53:11-04:00", "updated_at" => "2022-10-03T12:53:11-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 5, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266954", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266954/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBApeWT06EmF1dG9fYWN0aXZhdGVU--784a3d7ab3ffbe680e66bc9b6017f0b19a84eb94"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "pending", "return_url" => "http://yourapp.example.org", "billing_on" => "2022-10-03", "created_at" => "2022-10-03T12:44:45-04:00", "updated_at" => "2022-10-03T12:44:45-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVU--b5f90d04779cc5242b396e4054f2e650c5dace1c"}}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.find(
      id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.delete(
      id: 455696195,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 1029266953, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-10-03T12:53:09-04:00", "updated_at" => "2022-10-03T12:53:09-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266953", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266953/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAleWT06EmF1dG9fYWN0aXZhdGVU--1255bd14c50f77b5a2bab1190e116c8784e01280"}]}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.all(
      since_id: "455696195",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json?since_id=455696195")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "accepted", "return_url" => "http://yourapp.example.org", "billing_on" => "2022-10-03", "created_at" => "2022-10-03T12:44:45-04:00", "updated_at" => "2022-10-03T12:53:11-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195"}]}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"return_url" => "http://yourapp.example.org/", "id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "active", "billing_on" => nil, "created_at" => "2022-10-03T12:44:45-04:00", "updated_at" => "2022-10-03T12:53:07-04:00", "test" => nil, "activated_on" => "2022-10-03", "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "trial_ends_on" => "2022-10-03", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://yourapp.example.org/?charge_id=455696195", "update_capped_amount_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_update_capped_amount?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVG--4fa9614788ca5e1cf650a7e46ca7681295b568d8"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      recurring_application_charge: {"capped_amount" => "200"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
  end

end
