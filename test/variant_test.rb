require 'test_helper'

class VariantTest < Test::Unit::TestCase
  def setup
    super

    @version_unstable = ShopifyAPI::ApiVersion.find_version('unstable')
    @version_2019_07 = ShopifyAPI::ApiVersion.find_version('2019-07')
    @version_2019_10 = ShopifyAPI::ApiVersion.find_version('2019-10')
    @version_2020_01 = ShopifyAPI::ApiVersion.find_version('2020-01')

  end

  def test_get_variants
    fake "products/632910392/variants", :method => :get, :body => load_fixture('variants')

    variants = ShopifyAPI::Variant.find(:all, :params => { :product_id => 632910392 })
    assert_equal variants.map(&:id).sort, [39072856, 49148385, 457924702, 808950810]
  end

  def test_get_variant_namespaced
    fake "products/632910392/variants/808950810", :method => :get, :body => load_fixture('variant')

    v = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_equal 632910392, v.product_id
  end

  def test_get_variant
    fake "variants/808950810", :method => :get, :body => load_fixture('variant')

    v = ShopifyAPI::Variant.find(808950810)
    assert_equal 632910392, v.product_id
  end

  def test_product_id_should_be_accessible_if_via_product_endpoint
    fake "products/632910392/variants/808950810", :method => :get, :body => load_fixture('variant')

    v = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_equal 632910392, v.product_id
  end

  def test_product_id_should_be_accessible_if_via_variant_endpoint
    fake "variants/808950810", :method => :get, :body => load_fixture('variant')

    v = ShopifyAPI::Variant.find(808950810)
    assert_equal 632910392, v.product_id
  end

  def test_delete_variant
    fake "products/632910392/variants/808950810", :method => :get, :body => load_fixture('variant')
    fake "products/632910392/variants/808950810", :method => :delete, :body => 'destroyed'
    v = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert v.destroy
  end

  def test_deprecated_inventory_fields_are_included_in_2019_07
    ShopifyAPI::Base.api_version = '2019-07'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_07
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert variant.as_json.include?('inventory_quantity')
  end

  def test_deprecated_inventory_fields_are_removed_in_2020_01
    ShopifyAPI::Base.api_version = '2020-01'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2020_01
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    refute variant.as_json.include?('inventory_quantity')
  end

  def test_setting_variant_inventory_quantity_adjustment_passes_in_api_before_2019_10
    ShopifyAPI::Base.api_version = '2019-07'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_07
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    variant.inventory_quantity_adjustment = 8
  end

  def test_setting_variant_inventory_quantity_adjustment_fails_in_2019_10_api
    ShopifyAPI::Base.api_version = '2019-10'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_10
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_raises(ShopifyAPI::ValidationException) do
      variant.inventory_quantity_adjustment = 8
    end
  end

  def test_setting_variant_inventory_quantity_adjustment_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_unstable
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_raises(ShopifyAPI::ValidationException) do
      variant.inventory_quantity_adjustment = 8
    end
  end

  def test_setting_variant_inventory_quantity_passes_in_api_before_2019_10
    ShopifyAPI::Base.api_version = '2019-07'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_07
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    variant.inventory_quantity = 8
  end

  def test_setting_variant_inventory_quantity_fails_in_2019_10_api
    ShopifyAPI::Base.api_version = '2019-10'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_10
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_raises(ShopifyAPI::ValidationException) do
      variant.inventory_quantity = 8
    end
  end

  def test_setting_variant_inventory_quantity_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_unstable
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_raises(ShopifyAPI::ValidationException) do
      variant.inventory_quantity = 8
    end
  end

  def test_setting_variant_old_inventory_quantity_passes_in_api_before_2019_10
    ShopifyAPI::Base.api_version = '2019-07'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_07
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    variant.old_inventory_quantity = 8
  end

  def test_setting_variant_old_inventory_quantity_fails_in_2019_10_api
    ShopifyAPI::Base.api_version = '2019-10'
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_2019_10
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_raises(ShopifyAPI::ValidationException) do
      variant.old_inventory_quantity = 8
    end
  end

  def test_setting_variant_old_inventory_quantity_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    fake(
      "products/632910392/variants/808950810",
      method: :get,
      body: load_fixture('variant'),
      api_version: @version_unstable
    )
    variant = ShopifyAPI::Variant.find(808950810, :params => {:product_id => 632910392})
    assert_raises(ShopifyAPI::ValidationException) do
      variant.old_inventory_quantity = 8
    end
  end
end
