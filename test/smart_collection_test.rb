require 'test_helper'

class SmartCollectionTest < Test::Unit::TestCase
  test "Smart Collection creation" do
    fake "smart_collections", :method => :post, :status => 201, :body => load_fixture('smart_collection')
    rules = { :column => "title", :relation => "starts_with", :condition => "mac" }
    smart_collection = ShopifyAPI::SmartCollection.create(:title => "Macbooks", :rules => rules)
    assert_equal 1063001432, smart_collection.id
  end

  test "Smart Collection get products gets all products in a smart collection" do
    fake "smart_collections/1063001432", method: :get, status: 200, body: load_fixture('smart_collection')
    smart_collection = ShopifyAPI::SmartCollection.find(1063001432)

    fake "products.json?collection_id=1063001432",
      method: :get,
      status: 200,
      body:
      load_fixture('smart_collection_products'),
      extension: false
    assert_equal [632910392, 921728736], smart_collection.products.map(&:id)
  end

  test "Smart Collection get products with only_sorted=only_manual gets only manually sorted products" do
    fake "smart_collections/1063001432", method: :get, status: 200, body: load_fixture('smart_collection')
    smart_collection = ShopifyAPI::SmartCollection.find(1063001432)

    fake "smart_collections/1063001432/products.json?only_sorted=only_manual",
      method: :get,
      status: 200,
      body: load_fixture('smart_collection_products'),
      extension: false
    assert_equal [632910392, 921728736], smart_collection.products(only_sorted: "only_manual").map(&:id)
  end
end
