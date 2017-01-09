require 'test_helper'

class CollectionListingTest < Test::Unit::TestCase

  def test_get_collection_listings
    fake "applications/999/collection_listings", method: :get, status: 201, body: load_fixture('collection_listings')

    collection_listings = ShopifyAPI::CollectionListing.find(:all, params: { application_id: 999 })

    assert_equal 1, collection_listings.count
    assert_equal 1, collection_listings.first.collection_id
    assert_equal 'Home page', collection_listings.first.title
  end

  def test_get_collection_listing_for_collection_id
    fake "applications/999/collection_listings/1", method: :get, status: 201, body: load_fixture('collection_listing')

    collection_listing = ShopifyAPI::CollectionListing.find(1, params: { application_id: 999 })

    assert_equal 'Home page', collection_listing.title
  end

  # def test_get_collection_listing_product_ids
  #   fake "applications/999/collection_listings/product_ids", method: :get, status: 201, body: load_fixture('collection_listing_product_ids')

  #   product_ids = ShopifyAPI::CollectionListing.product_ids(params: { application_id: 999 })

  #   assert_equal 2, product_ids.count
  #   assert_equal 2, product_ids.first
  #   assert_equal 1, product_ids.last
  # end
end
