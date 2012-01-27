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
    assert_equal '{"metafield":{"namespace":"contact","key":"email","value":"123@example.com","value_type":"string"}}', FakeWeb.last_request.body
    assert !field.new_record?
    assert_equal "contact", field.namespace
    assert_equal "email", field.key
    assert_equal "123@example.com", field.value
  end

  def test_get_metafields_for_product
    fake "products/632910392/metafields", :body => load_fixture('metafields')

    metafields = @product.metafields

    assert_equal 2, metafields.length
    assert metafields.all?{|m| m.is_a?(ShopifyAPI::Metafield)}
  end
end
