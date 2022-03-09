# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class RecurringApplicationCharge202107Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266962, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-02-03T16:43:01-05:00", "updated_at" => "2022-02-03T16:43:01-05:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266962", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/1029266962/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBJeWT06EmF1dG9fYWN0aXZhdGVU--74d9d807e18dfbca41735317f5e768363d1624e2"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "capped_amount" => 100, "terms" => "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266963, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-02-03T16:43:02-05:00", "updated_at" => "2022-02-03T16:43:02-05:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "trial_ends_on" => nil, "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266963", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/1029266963/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBNeWT06EmF1dG9fYWN0aXZhdGVU--3264282fb3cc146d9671e6d7be87703f42881f15"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "trial_days" => 5}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266964, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-02-03T16:43:03-05:00", "updated_at" => "2022-02-03T16:43:03-05:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 5, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266964", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/1029266964/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBReWT06EmF1dG9fYWN0aXZhdGVU--15efe288887adbb6e91837f398ea009752112bdb"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266965, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-02-03T16:43:05-05:00", "updated_at" => "2022-02-03T16:43:05-05:00", "test" => true, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266965", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/1029266965/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBVeWT06EmF1dG9fYWN0aXZhdGVU--3f7857a16054f426f93abc51169aa4dfdd2a4c0e"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.test = true
    recurring_application_charge.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "accepted", "return_url" => "http://yourapp.com", "billing_on" => "2022-02-03", "created_at" => "2022-02-03T16:32:42-05:00", "updated_at" => "2022-02-03T16:42:34-05:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.com?charge_id=455696195"}]}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 1029266958, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2022-02-03T16:42:36-05:00", "updated_at" => "2022-02-03T16:42:36-05:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266958", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/1029266958/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBA5eWT06EmF1dG9fYWN0aXZhdGVU--f478748edf1ed8406a2bbe1f9a670dd6611cf7da"}]}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.all(
      since_id: "455696195",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges.json?since_id=455696195")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "pending", "return_url" => "http://yourapp.com", "billing_on" => "2022-02-03", "created_at" => "2022-02-03T16:32:42-05:00", "updated_at" => "2022-02-03T16:32:42-05:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.com?charge_id=455696195", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/455696195/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVU--b5f90d04779cc5242b396e4054f2e650c5dace1c"}}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.find(
      id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::RecurringApplicationCharge.delete(
      id: 455696195,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "active", "return_url" => "http://yourapp.com", "billing_on" => nil, "created_at" => "2022-02-03T16:32:42-05:00", "updated_at" => "2022-02-03T16:42:49-05:00", "test" => nil, "activated_on" => "2022-02-03", "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "trial_ends_on" => "2022-02-03", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://yourapp.com?charge_id=455696195", "update_capped_amount_url" => "https://jsmith.myshopify.com/admin/charges/455696195/confirm_update_capped_amount?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVG--c394192ebae94dcf5ba4b265d67b5f847fb99776"}}), headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      recurring_application_charge: {"capped_amount" => "200"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
  end

end
