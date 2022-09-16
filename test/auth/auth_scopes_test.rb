# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class AuthScopesTest < Test::Unit::TestCase
      def setup
        @read_orders = ShopifyAPI::Auth::AuthScopes.new(["read_orders"])
        @read_products = ShopifyAPI::Auth::AuthScopes.new(["read_products"])
        @read_write_orders = ShopifyAPI::Auth::AuthScopes.new(["read_orders", "write_orders"])
        @read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new(["read_products", "write_orders"])
        @write_orders = ShopifyAPI::Auth::AuthScopes.new(["write_orders"])
        @write_products = ShopifyAPI::Auth::AuthScopes.new(["write_products"])
        @write_products_and_orders = ShopifyAPI::Auth::AuthScopes.new(["write_products,", "write_orders"])
        @write_products_orders_customers = ShopifyAPI::Auth::AuthScopes.new(
          ["write_products", "write_orders", "write_customers"],
        )
      end

      def test_write_is_the_same_access_as_read_write_on_the_same_resource
        assert_equal(@write_orders, @read_write_orders)
      end

      def test_write_is_the_same_access_as_read_write_on_the_same_unauthenticated_resource
        unauthenticated_read_write_orders = ShopifyAPI::Auth::AuthScopes.new(
          ["unauthenticated_read_orders", "unauthenticated_write_orders"],
        )
        unauthenticated_write_orders = ShopifyAPI::Auth::AuthScopes.new(["unauthenticated_write_orders"])

        assert_equal(unauthenticated_write_orders, unauthenticated_read_write_orders)
      end

      def test_read_is_not_the_same_as_read_write_on_the_same_resource
        refute_equal(@read_write_orders, @read_orders)
      end

      def test_two_different_resources_are_not_equal
        refute_equal(@read_orders, @read_products)
      end

      def test_two_identical_scopes_are_equal
        read_orders_identical = ShopifyAPI::Auth::AuthScopes.new(["read_orders"])

        assert_equal(read_orders_identical, @read_orders)
      end

      def test_unauthenticated_is_not_implied_by_authenticated_access
        unauthenticated_orders = ShopifyAPI::Auth::AuthScopes.new(["unauthenticated_read_orders"])
        authenticated_read_orders = ShopifyAPI::Auth::AuthScopes.new(["read_orders"])
        authenticated_write_orders = ShopifyAPI::Auth::AuthScopes.new(["write_orders"])

        refute_equal(unauthenticated_orders, authenticated_read_orders)
        refute_equal(unauthenticated_orders, authenticated_write_orders)
      end

      def test_scopes_covers_is_truthy_for_same_scopes
        read_orders_identical = ShopifyAPI::Auth::AuthScopes.new(["read_orders"])

        assert(@read_orders.covers?(read_orders_identical))
      end

      def test_covers_is_falsy_for_different_scopes
        refute(@read_orders.covers?(@read_products))
      end

      def test_covers_is_truthy_for_read_when_the_set_has_read_write
        assert(@write_products.covers?(@read_products))
      end

      def test_covers_is_truthy_for_read_when_the_set_has_read_write_for_that_resource_and_others
        assert(@write_products_and_orders.covers?(@read_orders))
      end

      def test_covers_is_truthy_for_write_when_the_set_has_read_write_for_that_resource_and_others
        assert(@write_products_and_orders.covers?(@write_orders))
      end

      def test_covers_is_truthy_for_subset_of_scopes
        write_orders_products = ShopifyAPI::Auth::AuthScopes.new(["write_orders", "read_products"])

        assert(@write_products_orders_customers.covers?(write_orders_products))
      end

      def test_covers_is_falsy_for_sets_of_scopes_that_have_no_common_elements
        write_images_read_content = ShopifyAPI::Auth::AuthScopes.new(["write_images", "read_content"])

        refute(@write_products_orders_customers.covers?(write_images_read_content))
      end

      def test_covers_is_falsy_for_sets_of_scopes_that_have_only_some_common_access
        write_products_read_content = ShopifyAPI::Auth::AuthScopes.new(["write_products", "read_content"])

        refute(@write_products_orders_customers.covers?(write_products_read_content))
      end

      def test_duplicate_scopes_resolve_to_one_scope
        read_orders_duplicated = ShopifyAPI::Auth::AuthScopes.new(
          ["read_orders", "read_orders", "read_orders", "read_orders"],
        )

        assert_equal(@read_orders, read_orders_duplicated)
      end

      def test_to_s_outputs_scopes_as_a_comma_separated_list_without_implied_read_scopes
        serialized_read_products_write_orders = "read_products,write_orders"
        read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new(["read_products", "read_orders", "write_orders"])

        assert_equal(read_products_write_orders.to_s, serialized_read_products_write_orders)
      end

      def test_to_a_outputs_scopes_as_an_array_of_strings_without_implied_read_scopes
        serialized_read_products_write_orders = ["write_orders", "read_products"]
        read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new(["read_products", "read_orders", "write_orders"])

        assert_equal(read_products_write_orders.to_a.sort, serialized_read_products_write_orders.sort)
      end

      def test_creating_scopes_removes_extra_whitespace_from_scope_name_and_blank_scope_names
        deserialized_read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new(
          [" read_products", "  ", "write_orders "],
        )
        serialized_read_products_write_orders = deserialized_read_products_write_orders.to_s
        expected_read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new(["read_products", "write_orders"])

        assert_equal(expected_read_products_write_orders,
          ShopifyAPI::Auth::AuthScopes.new(serialized_read_products_write_orders))
      end

      def test_creating_scopes_from_a_string_works_with_a_comma_separated_list
        deserialized_read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new("read_products,write_orders")
        serialized_read_products_write_orders = deserialized_read_products_write_orders.to_s
        expected_read_products_write_orders = ShopifyAPI::Auth::AuthScopes.new(["read_products", "write_orders"])

        assert_equal(expected_read_products_write_orders,
          ShopifyAPI::Auth::AuthScopes.new(serialized_read_products_write_orders))
      end

      def test_using_to_s_from_one_scopes_to_construct_another_will_be_equal
        assert_equal(@read_products_write_orders, ShopifyAPI::Auth::AuthScopes.new(@read_products_write_orders.to_s))
      end

      def test_using_to_a_from_one_scopes_to_construct_another_will_be_equal
        assert_equal(@read_products_write_orders, ShopifyAPI::Auth::AuthScopes.new(@read_products_write_orders.to_a))
      end
    end
  end
end
