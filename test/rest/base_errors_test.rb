# typed: true
# frozen_string_literal: true

require_relative "../test_helper"
module ShopifyAPITest
  class BaseErrorsTest < Test::Unit::TestCase
    def test_discount_code_errors_attribute_does_not_replace_base_errors
      session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "token")
      ShopifyAPI::Context.activate_session(session)
      stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-10/price_rules/507328175/discount_codes.json")
        .to_return(status: 500, body: { errors: "Something went wrong" }.to_json, headers: {})

      discount_code = ShopifyAPI::DiscountCode.new
      discount_code.price_rule_id = 507328175
      discount_code.code = "SUMMERSALE10OFF"

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) { discount_code.save! }

      assert_nil(discount_code.errors)
      assert_equal([error], discount_code.instance_variable_get(:@base_errors).errors)
    ensure
      ShopifyAPI::Context.deactivate_session
    end

    def test_resource_errors_returns_base_errors
      session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "token")

      assert_instance_of(ShopifyAPI::Rest::BaseErrors, ShopifyAPI::Fulfillment.new(session: session).errors)
    end

    def test_outputs_error_message
      errors = ShopifyAPI::Rest::BaseErrors.new
      errors.errors << StandardError.new("Something went wrong")
      errors.errors << StandardError.new("Another thing went wrong")

      assert_equal(errors.full_messages, "Something went wrong\nAnother thing went wrong")
    end

    def test_outputs_error_code
      errors = ShopifyAPI::Rest::BaseErrors.new

      response = ShopifyAPI::Clients::HttpResponse.new(code: 404, body: {}, headers: {})
      errors.errors << ShopifyAPI::Errors::HttpResponseError.new(response: response)

      response = ShopifyAPI::Clients::HttpResponse.new(code: 405, body: {}, headers: {})
      errors.errors << ShopifyAPI::Errors::HttpResponseError.new(response: response)

      assert_equal(errors.codes, [404, 405])
    end
  end
end
