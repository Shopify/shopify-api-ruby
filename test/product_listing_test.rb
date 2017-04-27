require 'test_helper'

class ProductListingTest < Test::Unit::TestCase

  def test_get_product_listings
    fake "product_listings", method: :get, status: 201, body: load_fixture('product_listings')

    product_listings = ShopifyAPI::ProductListing.find(:all)
    assert_equal 2, product_listings.count
    assert_equal 2, product_listings.first.product_id
    assert_equal 1, product_listings.last.product_id
    assert_equal 'Synergistic Silk Chair', product_listings.first.title
    assert_equal 'Rustic Copper Bottle', product_listings.last.title
  end

  def test_get_product_listing
    fake "product_listings/2", method: :get, status: 201, body: load_fixture('product_listing')

    product_listing = ShopifyAPI::ProductListing.find(2)
    assert_equal 'Synergistic Silk Chair', product_listing.title
  end

  def test_reload_product_listing
    fake "product_listings/2", method: :get, status: 201, body: load_fixture('product_listing')

    product_listing = ShopifyAPI::ProductListing.new(product_id: 2)
    product_listing.reload

    assert_equal 'Synergistic Silk Chair', product_listing.title
  end

  def test_get_product_listing_product_ids
    fake "product_listings/product_ids", method: :get, status: 201, body: load_fixture('product_listing_product_ids')

    product_ids = ShopifyAPI::ProductListing.product_ids
    assert_equal 2, product_ids.count
    assert_equal 2, product_ids.first
    assert_equal 1, product_ids.last
  end
end
