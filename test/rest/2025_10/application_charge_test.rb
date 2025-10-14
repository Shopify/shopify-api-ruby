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

class ApplicationCharge202510Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2025-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "application_charge" => hash_including({"name" => "Super Duper Expensive action", "price" => 100.0, "return_url" => "http://super-duper.shopifyapps.com", "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"application_charge" => {"id" => 1017262359, "name" => "Super Duper Expensive action", "api_client_id" => 755357713, "price" => "100.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "test" => true, "created_at" => "2025-10-02T11:21:36-05:00", "updated_at" => "2025-10-02T11:21:36-05:00", "currency" => "USD", "charge_type" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1017262359", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1017262359/ApplicationCharge/confirm_application_charge?signature=BAh7BzoHaWRpBBcxojw6EmF1dG9fYWN0aXZhdGVU--53cb494fedf6f420ff06e85ed207a3442ea4447e"}}), headers: {})

    response = application_charge = ShopifyAPI::ApplicationCharge.new
    application_charge.name = "Super Duper Expensive action"
    application_charge.price = 100.0
    application_charge.return_url = "http://super-duper.shopifyapps.com"
    application_charge.test = true
    application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "application_charge" => hash_including({"name" => "Super Duper Expensive action", "price" => 100.0, "return_url" => "http://super-duper.shopifyapps.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"application_charge" => {"id" => 1017262360, "name" => "Super Duper Expensive action", "api_client_id" => 755357713, "price" => "100.00", "status" => "pending", "return_url" => "http://super-duper.shopifyapps.com/", "test" => nil, "created_at" => "2025-10-02T11:21:38-05:00", "updated_at" => "2025-10-02T11:21:38-05:00", "currency" => "USD", "charge_type" => nil, "decorated_return_url" => "http://super-duper.shopifyapps.com/?charge_id=1017262360", "confirmation_url" => "https://jsmith.myshopify.com/admin/charges/755357713/1017262360/ApplicationCharge/confirm_application_charge?signature=BAh7BzoHaWRpBBgxojw6EmF1dG9fYWN0aXZhdGVU--258ee22d3cebf17a9fbc35be9bc959c04aac0b06"}}), headers: {})

    response = application_charge = ShopifyAPI::ApplicationCharge.new
    application_charge.name = "Super Duper Expensive action"
    application_charge.price = 100.0
    application_charge.return_url = "http://super-duper.shopifyapps.com"
    application_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"application_charges" => [{"id" => 556467234, "name" => "Green theme", "api_client_id" => 755357713, "price" => "120.00", "status" => "accepted", "return_url" => "http://google.com", "test" => nil, "external_id" => nil, "created_at" => "2025-10-02T11:09:43-05:00", "updated_at" => "2025-10-02T11:09:43-05:00", "currency" => "USD", "charge_type" => "theme", "decorated_return_url" => "http://google.com?charge_id=556467234"}, {"id" => 675931192, "name" => "iPod Cleaning", "api_client_id" => 755357713, "price" => "5.00", "status" => "accepted", "return_url" => "http://google.com", "test" => nil, "created_at" => "2025-10-02T11:09:43-05:00", "updated_at" => "2025-10-02T11:09:43-05:00", "currency" => "USD", "charge_type" => nil, "decorated_return_url" => "http://google.com?charge_id=675931192"}, {"id" => 1017262346, "name" => "Create me a logo", "api_client_id" => 755357713, "price" => "123.00", "status" => "accepted", "return_url" => "http://google.com", "test" => nil, "created_at" => "2025-10-02T11:09:43-05:00", "updated_at" => "2025-10-02T11:09:43-05:00", "currency" => "USD", "charge_type" => "brokered_service", "decorated_return_url" => "http://google.com?charge_id=1017262346"}]}), headers: {})

    response = ShopifyAPI::ApplicationCharge.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json?since_id=556467234")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"application_charges" => [{"id" => 675931192, "name" => "iPod Cleaning", "api_client_id" => 755357713, "price" => "5.00", "status" => "accepted", "return_url" => "http://google.com", "test" => nil, "created_at" => "2025-10-02T11:09:43-05:00", "updated_at" => "2025-10-02T11:09:43-05:00", "currency" => "USD", "charge_type" => nil, "decorated_return_url" => "http://google.com?charge_id=675931192"}, {"id" => 1017262346, "name" => "Create me a logo", "api_client_id" => 755357713, "price" => "123.00", "status" => "accepted", "return_url" => "http://google.com", "test" => nil, "created_at" => "2025-10-02T11:09:43-05:00", "updated_at" => "2025-10-02T11:09:43-05:00", "currency" => "USD", "charge_type" => "brokered_service", "decorated_return_url" => "http://google.com?charge_id=1017262346"}]}), headers: {})

    response = ShopifyAPI::ApplicationCharge.all(
      since_id: "556467234",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges.json?since_id=556467234")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges/675931192.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"application_charge" => {"id" => 675931192, "name" => "iPod Cleaning", "api_client_id" => 755357713, "price" => "5.00", "status" => "accepted", "return_url" => "http://google.com", "test" => nil, "created_at" => "2025-10-02T11:09:43-05:00", "updated_at" => "2025-10-02T11:09:43-05:00", "currency" => "USD", "charge_type" => nil, "decorated_return_url" => "http://google.com?charge_id=675931192"}}), headers: {})

    response = ShopifyAPI::ApplicationCharge.find(
      id: 675931192,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/application_charges/675931192.json")

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
