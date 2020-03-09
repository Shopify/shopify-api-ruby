require 'test_helper'

class CollectionTest < Test::Unit::TestCase
  test "Collection get products gets all products in a collection on 2020-01 version" do
    available_version = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: '2020-01')
    ShopifyAPI::Base.activate_session(available_version)

    fake(
        'collections',
        url: 'https://shop2.myshopify.com/admin/api/2020-01/collections/1.json',
        method: :get,
        status: 200,
        body: load_fixture('collection'),
        extension: false
    )

    collection = ShopifyAPI::Collection.find(1)

    fake(
        'products',
        url: 'https://shop2.myshopify.com/admin/api/2020-01/collections/1/products.json',
        method: :get,
        status: 200,
        body: load_fixture('collection_products'),
        extension: false
    )
    assert_equal [632910392, 921728736], collection.products.map(&:id)
  end

  test "Collection get products fails on older api version" do
    old_version = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: '2019-10')
    ShopifyAPI::Base.activate_session(old_version)

    fake(
        'collections',
        url: 'https://shop2.myshopify.com/admin/api/2019-10/collections/1.json',
        method: :get,
        status: 200,
        body: load_fixture('collection'),
        extension: false
    )

    collection = ShopifyAPI::Collection.find(1)

    assert_raises NotImplementedError do
      collection.products
    end
  end
end
