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
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "trial_days" => 5}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266966, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-06-14T14:50:20-04:00", "updated_at" => "2023-06-14T14:50:20-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 5, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266966", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266966/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBZeWT06EmF1dG9fYWN0aXZhdGVU--a2c5ad38aeda769a5cb80dccb27399d4c24d2e2e", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "capped_amount" => 100, "terms" => "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266964, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-06-14T14:50:16-04:00", "updated_at" => "2023-06-14T14:50:16-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266964", "capped_amount" => "100.00", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266964/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBReWT06EmF1dG9fYWN0aXZhdGVU--7239a27757dbe011a007c3d2c36787b51c24af6c", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266967, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-06-14T14:50:28-04:00", "updated_at" => "2023-06-14T14:50:28-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266967", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266967/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBdeWT06EmF1dG9fYWN0aXZhdGVU--295989c40261e70fe85c382e864fb43b0829dc4b", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266962, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-06-14T14:50:04-04:00", "updated_at" => "2023-06-14T14:50:04-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => true, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266962", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266962/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBJeWT06EmF1dG9fYWN0aXZhdGVU--29a492d97c529d36a1df77526836d8a253060c34", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.test = true
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "billing_on" => "2023-06-14", "status" => "accepted", "created_at" => "2023-06-14T14:27:29-04:00", "updated_at" => "2023-06-14T14:50:05-04:00", "activated_on" => nil, "return_url" => "http://yourapp.example.org", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "currency" => "USD"}]}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 1029266965, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-06-14T14:50:18-04:00", "updated_at" => "2023-06-14T14:50:18-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266965", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266965/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBBVeWT06EmF1dG9fYWN0aXZhdGVU--41d682c525b812740be789eb48651fbe5e931d85", "currency" => "USD"}]}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.all(
      since_id: "455696195",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges.json?since_id=455696195")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "billing_on" => "2023-06-14", "status" => "pending", "created_at" => "2023-06-14T14:27:29-04:00", "updated_at" => "2023-06-14T14:27:29-04:00", "activated_on" => nil, "return_url" => "http://yourapp.example.org", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVU--b5f90d04779cc5242b396e4054f2e650c5dace1c", "currency" => "USD"}}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.find(
      id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.delete(
      id: 455696195,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "billing_on" => nil, "status" => "active", "created_at" => "2023-06-14T14:27:29-04:00", "updated_at" => "2023-06-14T14:50:26-04:00", "activated_on" => "2023-06-14", "return_url" => "http://yourapp.example.org", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => "2023-06-14", "api_client_id" => 755357713, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "capped_amount" => "100.00", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "update_capped_amount_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_update_capped_amount?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVG--105a128dbc51cc968cf86e1fec02ca319cd6b3cb", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      recurring_application_charge: {"capped_amount" => "200"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")

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
