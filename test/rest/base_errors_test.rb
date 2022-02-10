# typed: true
# frozen_string_literal: true

require_relative "../test_helper"
module ShopifyAPITest
  class BaseErrorsTest < Minitest::Test

    def test_outputs_error_message
      errors = ShopifyAPI::RestWrappers::BaseErrors.new
      errors.errors << StandardError.new("Something went wrong")
      errors.errors << StandardError.new("Another thing went wrong")

      assert_equal(errors.full_messages, "Something went wrong\nAnother thing went wrong")
    end
  end
end
