# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Utils
    class AttributesComparatorTest < Test::Unit::TestCase
      def test_attributes_comparator
        test_cases = [
          {
            name: "returns an empty hash when both are the same",
            original_attributes: {},
            updated_attributes: {},
            expected: {},
          },
          {
            name: "returns the same hash when diff does not contain a hash",
            original_attributes: {},
            updated_attributes: { "a" => 1, "b" => 2 },
            expected: { "a" => 1, "b" => 2 },
          },
          {
            name: "always use updated arrays",
            original_attributes: { "a" => [] },
            updated_attributes: { "a" => ["x", "y"] },
            expected: { "a" => ["x", "y"] },
          },
          {
            name: "allows setting empty array",
            original_attributes: { "a" => ["x", "y"] },
            updated_attributes: { "a" => [] },
            expected: { "a" => [] },
          },
          {
            name: "overwrites nested arrays with updated array values",
            original_attributes: { "a" => { "b" => [{ "c" => 1 }, { "c" => 2 }] } },
            updated_attributes: { "a" => { "b" => [{ "c" => 2 }] } },
            expected: { "a" => { "b" => [{ "c" => 2 }] } },
          },
          {
            name: "returns diff values for nested hashes",
            original_attributes: { "a" => { "x" => 99 } },
            updated_attributes: { "a" => { "x" => 1, "y" => 2 } },
            expected: { "a" => { "x" => 1, "y" => 2 } },
          },
          {
            name: "ignores unchanged attributes",
            original_attributes: { "a" => 1, "b" => 2 },
            updated_attributes: { "b" => 3 },
            expected: { "b" => 3 },
          },
          {
            name: "ignore nested unchanged attributes",
            original_attributes: { "a" => { "b" => 2, "c" => 3 } },
            updated_attributes: { "a" => { "b" => 2 } },
            expected: {},
          },
          {
            name: "only updates explicitly changed values",
            original_attributes: { "a" => 1, "b" => 2 },
            updated_attributes: { "b" => 2 },
            expected: {},
          },
          {
            name: "updates explicitly empty value",
            original_attributes: { "a" => { "b" => { "c" => 1 } } },
            updated_attributes: { "a" => { "b" => {} } },
            expected: { "a" => { "b" => {} } },
          },
          {
            name: "returns nil values",
            original_attributes: {},
            updated_attributes: { "a" => nil, "b" => 2 },
            expected: { "a" => nil, "b" => 2 },
          },
          {
            name: "returns nil value in nested hash",
            original_attributes: { "a" => { "b" => 1 } },
            updated_attributes: { "a" => { "b" => nil } },
            expected: { "a" => { "b" => nil } },
          },
          {
            name: "hash with numbered key not overwritten if updated value not array",
            original_attributes: { "a" => { 0 => "test", 1 => "test2" } },
            updated_attributes: { "a" => { 0 => "test3", 1 => "test4" } },
            expected: { "a" => { 0 => "test3", 1 => "test4" } },
          },
        ]

        test_cases.each do |test_case|
          assert_equal(
            test_case[:expected],
            ShopifyAPI::Utils::AttributesComparator.compare(
              test_case[:original_attributes],
              test_case[:updated_attributes],
            ),
            test_case[:name],
          )
        end
      end
    end
  end
end
