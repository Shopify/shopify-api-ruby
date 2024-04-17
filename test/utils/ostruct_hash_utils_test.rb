# typed: false
# frozen_string_literal: true

require_relative "../test_helper"
module ShopifyAPITest
  module Utils
    class OstructHashUtilsTest < Test::Unit::TestCase
      def setup
        @utils = ShopifyAPI::Utils::OstructHashUtils
        @ostruct = OpenStruct.new({ key1: "value1", key2: OpenStruct.new({ nested_key: "nested_value" }) })
        @hash = { "key1" => "value1", "key2" => { "nested_key" => "nested_value" } }
      end

      def test_open_struct_to_hash_with_open_struct
        assert_equal(@hash, @utils.open_struct_to_hash(@ostruct))
      end

      def test_ensure_hash_with_hash
        assert_equal(@hash, @utils.ensure_hash(@hash))
      end

      def test_ensure_hash_with_open_struct
        assert_equal(@hash, @utils.ensure_hash(@ostruct))
      end

    end
  end
end
