require 'test_helper'

class ProductListingTest < Test::Unit::TestCase

  def test_get_product_listings
    fake "applications/999/product_listings", method: :get, status: 201, body: load_fixture('product_listings')

    product_listings = ShopifyAPI::ProductListing.find(:all, params: { application_id: 999})

    assert_equal 2, product_listings.count

    assert_equal 2, product_listings.first.product_id
    assert_equal 1, product_listings.last.product_id
    assert_equal 'Synergistic Silk Chair', product_listings.first.title
    assert_equal 'Rustic Copper Bottle', product_listings.last.title
  end

end
