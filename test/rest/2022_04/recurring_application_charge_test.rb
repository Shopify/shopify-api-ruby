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
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266959, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-04-05T13:28:11-04:00", "updated_at" => "2022-04-05T13:28:11-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266959", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266959/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBA9eWT06EmF1dG9fYWN0aXZhdGVU--f6da6826caf9441c9fc206dd50a0882bd41fd770"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "capped_amount" => 100, "terms" => "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266960, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-04-05T13:28:12-04:00", "updated_at" => "2022-04-05T13:28:12-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "trial_ends_on" => nil, "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266960", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266960/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBBeWT06EmF1dG9fYWN0aXZhdGVU--5c3bd24754b53de0b6aa0e5891c8753e3846b472"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266961, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-04-05T13:28:13-04:00", "updated_at" => "2022-04-05T13:28:13-04:00", "test" => true, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266961", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266961/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBFeWT06EmF1dG9fYWN0aXZhdGVU--ab48484a59366d23ac71d21f02214ef9a33c505b"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.test = true
    recurring_application_charge.save()

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
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266962, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-04-05T13:28:14-04:00", "updated_at" => "2022-04-05T13:28:14-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 5, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266962", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266962/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBJeWT06EmF1dG9fYWN0aXZhdGVU--4f67932551909100f62bd7ac5b7da60b1919d1f3"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "accepted", "return_url" => "http://yourapp.com", "billing_on" => "2022-04-05", "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:27:42-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.com?charge_id=455696195"}]}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 1029266955, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-04-05T13:27:44-04:00", "updated_at" => "2022-04-05T13:27:44-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266955", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266955/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAteWT06EmF1dG9fYWN0aXZhdGVU--cbd0bc5a93ee87d2196776b734d418f7bd15b2a8"}]}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.all(
      since_id: "455696195",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json?since_id=455696195")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "pending", "return_url" => "http://yourapp.com", "billing_on" => "2022-04-05", "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.com?charge_id=455696195", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVU--b5f90d04779cc5242b396e4054f2e650c5dace1c"}}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.find(
      id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_8()
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
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"return_url" => "http://yourapp.com/", "id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "active", "billing_on" => nil, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:27:51-04:00", "test" => nil, "activated_on" => "2022-04-05", "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "trial_ends_on" => "2022-04-05", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://yourapp.com/?charge_id=455696195", "update_capped_amount_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_update_capped_amount?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVG--f22d88ab510ea02154922370bbb05763703912cd"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      recurring_application_charge: {"capped_amount" => "200"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
  end

end
