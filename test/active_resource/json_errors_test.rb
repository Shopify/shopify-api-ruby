require 'test_helper'

module ActiveResource
  class JsonErrorsTest < Test::Unit::TestCase
    def test_parsing_of_error_json_hash
      @model = ShopifyAPI::Order.new
      @model.errors.from_json({ errors: { name: ['missing'] } }.to_json)
      assert_equal(['missing'], @model.errors[:name])
    end

    def test_parsing_of_error_json_plain_string
      @model = ShopifyAPI::Order.new
      @model.errors.from_json({ errors: 'some generic error' }.to_json)
      assert_equal(['some generic error'], @model.errors[:base])
      assert_equal('some generic error', @model.errors.full_messages.to_sentence)
    end
  end
end
