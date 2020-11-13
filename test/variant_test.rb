# frozen_string_literal: true
require 'test_helper'

class VariantTest < Test::Unit::TestCase
  def setup
    super
    refresh_variant
  end

  def test_get_variants
    fake("products/632910392/variants", method: :get, body: load_fixture('variants'))

    variants = ShopifyAPI::Variant.find(:all, params: { product_id: 632910392 })
    assert_equal(variants.map(&:id).sort, [39072856, 49148385, 457924702, 808950810])
  end

  def test_get_variant_namespaced
    assert_equal(632910392, @variant.product_id)
  end

  def test_get_variant
    assert_equal(632910392, @variant.product_id)
  end

  def test_product_id_should_be_accessible_if_via_product_endpoint
    assert_equal(632910392, @variant.product_id)
  end

  def test_product_id_should_be_accessible_if_via_variant_endpoint
    assert_equal(632910392, @variant.product_id)
  end

  def test_delete_variant
    fake("products/632910392/variants/808950810", method: :delete, body: 'destroyed')
    assert(@variant.destroy)
  end

  def test_read_only_inventory_quantity
    ShopifyAPI::Base.api_version = '2020-01'
    refresh_variant(api_version: ShopifyAPI::Base.api_version)
    assert_equal(10, @variant.inventory_quantity)
  end

  def test_setting_variant_inventory_quantity_adjustment_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    assert_raises(ShopifyAPI::ValidationException) do
      @variant.inventory_quantity_adjustment = 8
    end
  end

  def test_setting_variant_inventory_quantity_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    assert_raises(ShopifyAPI::ValidationException) do
      @variant.inventory_quantity = 8
    end
  end

  def test_setting_variant_old_inventory_quantity_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    assert_raises(ShopifyAPI::ValidationException) do
      @variant.old_inventory_quantity = 8
    end
  end

  private

  def refresh_variant(api_version: nil)
    fake(
      "products/632910392/variants/808950810", method: :get, body: load_fixture('variant'), api_version: api_version
    )
    @variant = ShopifyAPI::Variant.find(808950810, params: { product_id: 632910392 })
  end
end
