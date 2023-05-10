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

class RecurringApplicationCharge202301Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "billing_account_id" => 770125316, "trial_days" => 5}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266949, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2023-03-15T19:58:33-04:00", "updated_at" => "2023-03-15T19:58:33-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 5, "currency" => "USD", "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266949", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266949/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAVeWT06EmF1dG9fYWN0aXZhdGVU--43d5fff3021ed7c13d446ed4072a98860320778c"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.billing_account_id = 770125316
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "billing_account_id" => 770125316, "capped_amount" => 100, "terms" => "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266948, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2023-03-15T19:58:32-04:00", "updated_at" => "2023-03-15T19:58:32-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "currency" => "USD", "trial_ends_on" => nil, "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266948", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266948/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAReWT06EmF1dG9fYWN0aXZhdGVU--b77519e009b7d2708251f95dfafa43f171078adb"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.billing_account_id = 770125316
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "billing_account_id" => 770125316}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266950, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2023-03-15T19:58:36-04:00", "updated_at" => "2023-03-15T19:58:36-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "currency" => "USD", "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266950", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266950/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAZeWT06EmF1dG9fYWN0aXZhdGVU--881f4e1920d71cf3212bc9b7d47bd383d18f342e"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.billing_account_id = 770125316
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "billing_account_id" => 770125316, "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266952, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2023-03-15T19:58:42-04:00", "updated_at" => "2023-03-15T19:58:42-04:00", "test" => true, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "currency" => "USD", "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266952", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266952/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAheWT06EmF1dG9fYWN0aXZhdGVU--ba03eaa049cdf986b03cbd7e8e88a42b24a729b9"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.billing_account_id = 770125316
    recurring_application_charge.test = true
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "accepted", "return_url" => "http://yourapp.example.org", "billing_on" => "2023-03-15", "created_at" => "2023-03-15T19:57:32-04:00", "updated_at" => "2023-03-15T19:58:55-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "currency" => "USD", "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195"}]}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 1029266953, "name" => "Super Duper Plan", "api_client_id" => 755357713, "price" => "10.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "billing_on" => nil, "created_at" => "2023-03-15T19:58:46-04:00", "updated_at" => "2023-03-15T19:58:46-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "currency" => "USD", "trial_ends_on" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266953", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266953/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAleWT06EmF1dG9fYWN0aXZhdGVU--83e2128d52ca4a1d9cec474ace66ce7d2d34094e"}]}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.all(
      since_id: "455696195",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges.json?since_id=455696195")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "api_client_id" => 755357713, "price" => "15.00", "status" => "pending", "return_url" => "http://yourapp.example.org", "billing_on" => "2023-03-15", "created_at" => "2023-03-15T19:57:32-04:00", "updated_at" => "2023-03-15T19:57:32-04:00", "test" => nil, "activated_on" => nil, "cancelled_on" => nil, "trial_days" => 0, "currency" => "USD", "trial_ends_on" => nil, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVU--b5f90d04779cc5242b396e4054f2e650c5dace1c"}}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.find(
      id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges/455696195.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.delete(
      id: 455696195,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges/455696195.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"api_client_id" => 755357713, "return_url" => "http://yourapp.example.org/", "id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "status" => "active", "billing_on" => nil, "created_at" => "2023-03-15T19:57:32-04:00", "updated_at" => "2023-03-15T19:58:26-04:00", "test" => nil, "activated_on" => "2023-03-15", "cancelled_on" => nil, "trial_days" => 0, "capped_amount" => "100.00", "currency" => "USD", "trial_ends_on" => "2023-03-15", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "decorated_return_url" => "http://yourapp.example.org/?charge_id=455696195", "update_capped_amount_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_update_capped_amount?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVG--2fd57c881ec6e72c98d2d0f6f4091d9f3c475887"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      recurring_application_charge: {"capped_amount" => "200"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")

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
