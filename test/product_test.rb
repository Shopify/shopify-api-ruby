require 'test_helper'

class ProductTest < Test::Unit::TestCase
  def setup
    super

    fake "products/632910392", :body => load_fixture('product')
    @product = ShopifyAPI::Product.find(632910392)
  end

  def test_add_metafields_to_product
    fake "products/632910392/metafields", :method => :post, :status => 201, :body => load_fixture('metafield')

    field = @product.add_metafield(ShopifyAPI::Metafield.new(:namespace => "contact", :key => "email", :value => "123@example.com", :value_type => "string"))
    assert_equal ActiveSupport::JSON.decode('{"metafield":{"namespace":"contact","key":"email","value":"123@example.com","value_type":"string"}}'), ActiveSupport::JSON.decode(WebMock.last_request.body)
    assert !field.new_record?
    assert_equal "contact", field.namespace
    assert_equal "email", field.key
    assert_equal "123@example.com", field.value
  end

  def test_get_all_metafields_for_product
    fake "products/632910392/metafields", :body => load_fixture('metafields')

    metafields = @product.metafields

    assert_equal 3, metafields.length
    assert metafields.all? { |m| m.is_a? ShopifyAPI::Metafield }
  end

  def test_get_2_metafields_for_product
    body = ActiveSupport::JSON.decode load_fixture 'metafields'
    body['metafields'].slice! 2, 1

    fake 'products/632910392/metafields.json?limit=2', body: body.to_json, extension: false

    metafields = @product.metafields limit: 2

    assert_equal 2, metafields.length
    assert metafields.all? { |m| m.is_a? ShopifyAPI::Metafield }
  end

  def test_update_loaded_variant
    fake "products/632910392/variants/808950810", :method => :put, :status => 200, :body => load_fixture('variant')

    variant = @product.variants.first
    variant.price = "0.50"
    variant.save
  end

  def test_price_range
    assert_equal('199.00', @product.price_range)
  end

  def test_price_range_when_has_different_price
    @product.variants[0].price = '100.00'

    assert_equal('100.00 - 199.00', @product.price_range)
  end

  def test_deprecated_variant_inventory_fields_are_included_in_2019_07
    ShopifyAPI::Base.api_version = '2019-07'
    variant = @product.variants.first
    assert variant.as_json.include?('inventory_quantity')
  end

  def test_deprecated_variant_inventory_fields_are_removed_in_2020_01
    ShopifyAPI::Base.api_version = '2020-01'
    variant = @product.variants.first
    refute variant.as_json.include?('inventory_quantity')
  end

  def test_deprecated_inventory_fields_are_removed_in_2020_01
    ShopifyAPI::Base.api_version = '2020-01'
    refute @product.as_json.include?('total_inventory')
  end

  def test_setting_product_total_inventory_passes_in_api_before_2019_10
    ShopifyAPI::Base.api_version = '2019-07'
    fake("products/632910392", { :body => load_fixture('product') })
    @product.total_inventory = 8
  end

  def test_setting_product_total_inventory_fails_in_2019_10_api
    ShopifyAPI::Base.api_version = '2019-10'
    fake("products/632910392", { :body => load_fixture('product') })
    assert_raises(ShopifyAPI::ValidationException) do
      @product.total_inventory = 8
    end
  end

  def test_setting_product_total_inventory_fails_in_the_unstable_api
    ShopifyAPI::Base.api_version = :unstable
    fake("products/632910392", { :body => load_fixture('product') })
    assert_raises(ShopifyAPI::ValidationException) do
      @product.total_inventory = 8
    end
  end
end
