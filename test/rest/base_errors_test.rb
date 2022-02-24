# typed: true
# frozen_string_literal: true

require_relative "../test_helper"
module ShopifyAPITest
  class BaseErrorsTest < Minitest::Test

    def test_outputs_error_message
      errors = ShopifyAPI::Rest::BaseErrors.new
      errors.errors << StandardError.new("Something went wrong")
      errors.errors << StandardError.new("Another thing went wrong")

      assert_equal(errors.full_messages, "Something went wrong\nAnother thing went wrong")
    end

    def test_outputs_error_code
      errors = ShopifyAPI::Rest::BaseErrors.new
      errors.errors << ShopifyAPI::Errors::HttpResponseError.new(code: 404)
      errors.errors << ShopifyAPI::Errors::HttpResponseError.new(code: 405)

      assert_equal(errors.codes, [404, 405])
    end
  end
end
