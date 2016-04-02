require 'test_helper'

class SmartCollectionTest < Test::Unit::TestCase
  test "Smart Collection creation" do
    fake "smart_collections", :method => :post, :status => 201, :body => load_fixture('smart_collection')
    smart_collection = ShopifyAPI::SmartCollection.create(:title => "Macbooks", :published => false)
    assert_equal 1063001432, smart_collection.id
  end
end
