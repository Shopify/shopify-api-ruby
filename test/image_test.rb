require 'test_helper'

class ImageTest < Test::Unit::TestCase
  def setup
    super

    fake "products/632910392", :body => load_fixture('product')
    @product = ShopifyAPI::Product.find(632910392)
    fake "products/632910392/images/850703190", :body => load_fixture('image')
    @image = @product.images.first
  end

  def test_add_metafields_to_image
    fake "images/850703190/metafields", :method => :post, :status => 201, :body => load_fixture('metafield')

    field = @image.add_metafield(ShopifyAPI::Metafield.new(:namespace => "contact", :key => "email", :value => "123@example.com", :value_type => "string"))
    assert_equal ActiveSupport::JSON.decode('{"metafield":{"namespace":"contact","key":"email","value":"123@example.com","value_type":"string"}}'), ActiveSupport::JSON.decode(FakeWeb.last_request.body)
    assert !field.new_record?
    assert_equal "contact", field.namespace
    assert_equal "email", field.key
    assert_equal "123@example.com", field.value
  end

  def test_get_all_metafields_for_image
    fake "images/850703190/metafields", :body => load_fixture('metafields')

    metafields = @image.metafields

    assert_equal 3, metafields.length
    assert metafields.all?{ |m| m.is_a? ShopifyAPI::Metafield }
  end

  def test_get_2_metafields_for_product
    body = ActiveSupport::JSON.decode load_fixture 'metafields'
    body['metafields'].slice! 2, 1

    fake 'images/850703190/metafields.json?limit=2', body: body.to_json, extension: false

    metafields = @image.metafields limit: 2

    assert_equal 2, metafields.length
    assert metafields.all?{ |m| m.is_a? ShopifyAPI::Metafield }
  end

  def test_create_image
    fake "products/632910392/images", :method => :post, :body => load_fixture('image')
    image = ShopifyAPI::Image.new(:product_id => 632910392)
    image.position = 1
    image.attachment = "R0lGODlhbgCMAPf/APbr48VySrxTO7IgKt2qmKQdJeK8lsFjROG5p/nz7Zg3MNmnd7Q1MLNVS9GId71hSJMZIuzTu4UtKbeEeakhKMl8U8WYjfr18YQaIbAf=="
    image.save

    assert_equal 'http://cdn.shopify.com/s/files/1/0006/9093/3842/products/ipod-nano.png?v=1389388540', image.src
    assert_equal 850703190, image.id
  end

  def test_get_images
    fake "products/632910392/images", :method => :get, :body => load_fixture('images')
    image = ShopifyAPI::Image.find(:all, :params => {:product_id => 632910392})
    assert_equal 2, image.size
  end

  def test_get_image
    fake "products/632910392/images/850703190", :method => :get, :body => load_fixture('image')
    image = ShopifyAPI::Image.find(850703190, :params => {:product_id => 632910392})
    assert_equal 850703190, image.id
  end

  def test_delete_image
    fake "products/632910392/images/850703190", :method => :get, :body => load_fixture('image')
    fake "products/632910392/images/850703190", :method => :delete, :body => "destroyed"
    image = ShopifyAPI::Image.find(850703190, :params => {:product_id => 632910392})
    assert image.destroy
  end

  def test_delete_image_without_fetching
    fake "products/632910392/images/850703190", :method => :delete, :body => "destroyed"
    image = ShopifyAPI::Image.new(product_id: 632910392, id: 850703190)
    assert image.destroy
  end
end
