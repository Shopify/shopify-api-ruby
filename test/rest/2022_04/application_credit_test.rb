# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ApplicationCredit202204Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "application_credit" => hash_including({"description" => "application credit for refund", "amount" => 5.0}) }
      )
      .to_return(status: 200, body: JSON.generate({"application_credit" => {"id" => 1031636125, "amount" => "5.00", "description" => "application credit for refund", "test" => nil}}), headers: {})

    application_credit = ShopifyAPI::ApplicationCredit.new
    application_credit.description = "application credit for refund"
    application_credit.amount = 5.0
    application_credit.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "application_credit" => hash_including({"description" => "application credit for refund", "amount" => 5.0, "test" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"application_credit" => {"id" => 1031636126, "amount" => "5.00", "description" => "application credit for refund", "test" => true}}), headers: {})

    application_credit = ShopifyAPI::ApplicationCredit.new
    application_credit.description = "application credit for refund"
    application_credit.amount = 5.0
    application_credit.test = true
    application_credit.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"application_credits" => [{"id" => 140583599, "amount" => "5.00", "description" => "credit for application refund", "test" => nil}]}), headers: {})

    ShopifyAPI::ApplicationCredit.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits/140583599.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"application_credit" => {"id" => 140583599, "amount" => "5.00", "description" => "credit for application refund", "test" => nil}}), headers: {})

    ShopifyAPI::ApplicationCredit.find(
      id: 140583599,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/application_credits/140583599.json")
  end

end
