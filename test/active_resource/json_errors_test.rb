require 'test_helper'

module ActiveResource
  class JsonErrorsTest < Test::Unit::TestCase

    def test_parsing_of_error_json_hash
      errors = some_error.from_json({errors: {name: ['missing']}}.to_json)
      assert_equal({"name"=>["missing"]}, errors)
    end

    def test_parsing_of_error_json_plain_string
      errors = some_error.from_json({errors: 'some generic error'}.to_json)
      assert_equal(["some generic error"], errors)
    end

    private

    def some_error
      ActiveResource::Errors.new(ShopifyAPI::Order.new)
    end
  end
end
