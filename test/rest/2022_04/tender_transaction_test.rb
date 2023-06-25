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

class TenderTransaction202204Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tender_transactions" => [{"id" => 1011222851, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-07T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}, {"id" => 1011222850, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-05T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}]}), headers: {})

    response = ShopifyAPI::TenderTransaction.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?since_id=1011222852")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tender_transactions" => [{"id" => 1011222853, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-07T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}]}), headers: {})

    response = ShopifyAPI::TenderTransaction.all(
      since_id: "1011222852",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?since_id=1011222852")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?order=processed_at+ASC")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tender_transactions" => [{"id" => 1011222858, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-05T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}, {"id" => 1011222859, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-07T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}]}), headers: {})

    response = ShopifyAPI::TenderTransaction.all(
      order: "processed_at ASC",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?order=processed_at+ASC")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?processed_at_min=2005-08-06+10%3A22%3A51+-0400")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tender_transactions" => [{"id" => 1011222843, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-07T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}]}), headers: {})

    response = ShopifyAPI::TenderTransaction.all(
      processed_at_min: "2005-08-06 10:22:51 -0400",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?processed_at_min=2005-08-06+10%3A22%3A51+-0400")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?processed_at_max=2005-08-06+10%3A22%3A51+-0400")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tender_transactions" => [{"id" => 1011222856, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-05T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}]}), headers: {})

    response = ShopifyAPI::TenderTransaction.all(
      processed_at_max: "2005-08-06 10:22:51 -0400",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?processed_at_max=2005-08-06+10%3A22%3A51+-0400")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?processed_at_max=2005-08-05+10%3A22%3A51+-0400")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"tender_transactions" => [{"id" => 1011222840, "order_id" => 450789469, "amount" => "250.94", "currency" => "USD", "user_id" => nil, "test" => false, "processed_at" => "2005-08-05T10:22:51-04:00", "remote_reference" => "authorization-key", "payment_details" => nil, "payment_method" => "credit_card"}]}), headers: {})

    response = ShopifyAPI::TenderTransaction.all(
      processed_at_max: "2005-08-05 10:22:51 -0400",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/tender_transactions.json?processed_at_max=2005-08-05+10%3A22%3A51+-0400")

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
