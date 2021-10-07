# frozen_string_literal: true
require 'test_helper'

class HmacParamsTest < Test::Unit::TestCase
  test "cgi param keys are prepared for hmac validation by encoding equals, ampersand, and percent characters" do
    assert_equal(
      "abcd%26%3D%251234",
      ShopifyAPI::HmacParams.encode_key("abcd&=%1234")
    )
  end

  test "cgi param values are prepared for hmac validation by encoding ampersand and percent characters" do
    assert_equal(
      "abcd%26=%251234",
      ShopifyAPI::HmacParams.encode_value("abcd&=%1234")
    )
  end

  test "cgi params are encoded properly for hmac validation" do
    assert_equal(
      "abcd%26%3D%251234=abcd%26=%251234",
      ShopifyAPI::HmacParams.encode({"abcd&=%1234" => "abcd&=%1234"})
    )
  end
end
