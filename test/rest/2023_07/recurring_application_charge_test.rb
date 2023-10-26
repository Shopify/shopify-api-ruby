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

class RecurringApplicationCharge202307Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "trial_days" => 5}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266953, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-10-03T13:19:22-04:00", "updated_at" => "2023-10-03T13:19:22-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 5, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266953", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266953/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAleWT06EmF1dG9fYWN0aXZhdGVU--f952cc89aeaf445af65fad62640dfaec2dedfd6c", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "capped_amount" => 100, "terms" => "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266950, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-10-03T13:19:15-04:00", "updated_at" => "2023-10-03T13:19:15-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266950", "capped_amount" => "100.00", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266950/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAZeWT06EmF1dG9fYWN0aXZhdGVU--8f9a5315538aa752403c78ae37c7901038b51ddb", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266949, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-10-03T13:19:10-04:00", "updated_at" => "2023-10-03T13:19:10-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266949", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266949/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAVeWT06EmF1dG9fYWN0aXZhdGVU--74d3c63d142982ea850e223587b7103142421fe6", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({"name" => "Super Duper Plan", "price" => 10.0, "return_url" => "http://super-duper.shopifyapps.com", "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 1029266952, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-10-03T13:19:20-04:00", "updated_at" => "2023-10-03T13:19:20-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => true, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266952", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266952/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAheWT06EmF1dG9fYWN0aXZhdGVU--81b4fae10d89c3d6af238e85aa9aa81241585a55", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.test = true
    recurring_application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "billing_on" => "2023-10-03", "status" => "accepted", "created_at" => "2023-10-03T13:17:01-04:00", "updated_at" => "2023-10-03T13:19:19-04:00", "activated_on" => nil, "return_url" => "http://yourapp.example.org", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "currency" => "USD"}]}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charges" => [{"id" => 1029266951, "name" => "Super Duper Plan", "price" => "10.00", "billing_on" => nil, "status" => "pending", "created_at" => "2023-10-03T13:19:17-04:00", "updated_at" => "2023-10-03T13:19:17-04:00", "activated_on" => nil, "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1029266951", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1029266951/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBAdeWT06EmF1dG9fYWN0aXZhdGVU--08a47fed09b4a8a225201df64e66e918ba058974", "currency" => "USD"}]}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.all(
      since_id: "455696195",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges.json?since_id=455696195")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "billing_on" => "2023-10-03", "status" => "pending", "created_at" => "2023-10-03T13:17:01-04:00", "updated_at" => "2023-10-03T13:17:01-04:00", "activated_on" => nil, "return_url" => "http://yourapp.example.org", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => nil, "api_client_id" => 755357713, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_recurring_application_charge?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVU--b5f90d04779cc5242b396e4054f2e650c5dace1c", "currency" => "USD"}}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.find(
      id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges/455696195.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges/455696195.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::RecurringApplicationCharge.delete(
      id: 455696195,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges/455696195.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"recurring_application_charge" => {"id" => 455696195, "name" => "Super Mega Plan", "price" => "15.00", "billing_on" => nil, "status" => "active", "created_at" => "2023-10-03T13:17:01-04:00", "updated_at" => "2023-10-03T13:19:22-04:00", "activated_on" => "2023-10-03", "return_url" => "http://yourapp.example.org", "test" => nil, "cancelled_on" => nil, "trial_days" => 0, "trial_ends_on" => "2023-10-03", "api_client_id" => 755357713, "decorated_return_url" => "http://yourapp.example.org?charge_id=455696195", "capped_amount" => "100.00", "balance_used" => 0.0, "balance_remaining" => 100.0, "risk_level" => 0, "update_capped_amount_url" => "https://jsmith.myshopify.com/admin/charges/755357713/455696195/RecurringApplicationCharge/confirm_update_capped_amount?signature=BAh7BzoHaWRpBENfKRs6EmF1dG9fYWN0aXZhdGVG--71343d634655552df57c5871b146155d64382822", "currency" => "USD"}}), headers: {})

    response = recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      recurring_application_charge: {"capped_amount" => "200"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-07/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")

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
