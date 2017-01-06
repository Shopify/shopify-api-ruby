require 'test_helper'

class ProductListingTest < Test::Unit::TestCase

  def test_get_product_listings
    fake "product_listings/999", method: :get, status: 201, body: load_fixture('product_listings')

    product_listings = ShopifyAPI::ProductListing.find(:all, params: { application_id: 999})

    assert_equal 2, product_listings.count
    assert_equal 2, product_listings.first.id
    assert_equal 1, product_listings.last.id
    assert_equal 'Synergistic Silk Chair', product_listings.first.title
    assert_equal 'Rustic Marble Bottle', product_listings.last.title
  end

end
