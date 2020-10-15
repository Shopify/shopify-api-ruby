require 'test_helper'

class ProductListingTest < Test::Unit::TestCase

  def test_get_product_listings
    fake("product_listings", method: :get, status: 201, body: load_fixture('product_listings'))

    product_listings = ShopifyAPI::ProductListing.find(:all)
    assert_equal(2, product_listings.count)
    assert_equal(2, product_listings.first.product_id)
    assert_equal(1, product_listings.last.product_id)
    assert_equal('Synergistic Silk Chair', product_listings.first.title)
    assert_equal('Rustic Copper Bottle', product_listings.last.title)
  end

  def test_get_product_listing
    fake("product_listings/2", method: :get, status: 201, body: load_fixture('product_listing'))

    product_listing = ShopifyAPI::ProductListing.find(2)
    assert_equal('Synergistic Silk Chair', product_listing.title)
  end

  def test_reload_product_listing
    fake("product_listings/2", method: :get, status: 201, body: load_fixture('product_listing'))

    product_listing = ShopifyAPI::ProductListing.new(product_id: 2)
    product_listing.reload

    assert_equal('Synergistic Silk Chair', product_listing.title)
  end

  def test_get_product_listing_product_ids
    fake("product_listings/product_ids", method: :get, status: 201, body: load_fixture('product_listing_product_ids'))

    product_ids = ShopifyAPI::ProductListing.product_ids
    assert_equal(2, product_ids.count)
    assert_equal(4, product_ids.first)
    assert_equal(3, product_ids.last)
  end

  def test_get_product_listing_product_ids_multi_page_with_cursor
    version = ShopifyAPI::ApiVersion.find_version('2019-10')
    ShopifyAPI::Base.api_version = version.to_s

    url = "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/product_listings/product_ids.json"

    next_page_info = "notarealpageinfobutthatsokay"
    next_page_url = "#{url}?page_info=#{next_page_info}"
    link_header = "<#{next_page_url}>; rel=\"next\""

    fake(
      "product_listings/product_ids",
      method: :get,
      status: 201,
      url: url,
      body: load_fixture('product_listing_product_ids'),
      link: link_header,
    )

    product_ids = ShopifyAPI::ProductListing.product_ids
    assert_equal([4, 3], product_ids)
    assert(product_ids.next_page?)

    fake(
      "product_listings/product_ids",
      method: :get,
      status: 201,
      url: next_page_url,
      body: load_fixture('product_listing_product_ids2'),
      link: link_header,
    )

    next_page = product_ids.fetch_next_page
    assert_equal([2, 1], next_page)
  end

  def test_get_product_listing_product_ids_multi_page_with_cursor_fails_on_older_api_version
    version = ShopifyAPI::ApiVersion.find_version('2019-07')
    ShopifyAPI::Base.api_version = version.to_s

    url = "https://this-is-my-test-shop.myshopify.com/admin/api/2019-07/product_listings/product_ids.json"

    fake(
      "product_listings/product_ids",
      method: :get,
      status: 201,
      url: url,
      body: load_fixture('product_listing_product_ids'),
    )

    product_ids = ShopifyAPI::ProductListing.product_ids
    assert_equal([4, 3], product_ids)
    assert_raises(NotImplementedError) do
      product_ids.next_page?
    end
  end
end
