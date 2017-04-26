require 'test_helper'

class CollectionListingTest < Test::Unit::TestCase

  def test_get_collection_listings
    fake "collection_listings", method: :get, status: 201, body: load_fixture('collection_listings')

    collection_listings = ShopifyAPI::CollectionListing.find(:all)

    assert_equal 1, collection_listings.count
    assert_equal 1, collection_listings.first.collection_id
    assert_equal 'Home page', collection_listings.first.title
  end

  def test_get_collection_listing_for_collection_id
    fake "collection_listings/1", method: :get, status: 201, body: load_fixture('collection_listing')
    fake "collection_listings//1/product_ids", method: :get, status: 201, body: load_fixture('collection_listing_product_ids')

    collection_listing = ShopifyAPI::CollectionListing.find(1)

    assert_equal 1, collection_listing.collection_id
    assert_equal 'Home page', collection_listing.title
    assert_equal [1, 2], collection_listing.product_ids
  end
end
