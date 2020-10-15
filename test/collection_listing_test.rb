require 'test_helper'

class CollectionListingTest < Test::Unit::TestCase

  def test_get_collection_listings
    fake("collection_listings", method: :get, status: 201, body: load_fixture('collection_listings'))

    collection_listings = ShopifyAPI::CollectionListing.find(:all)

    assert_equal(1, collection_listings.count)
    assert_equal(1, collection_listings.first.collection_id)
    assert_equal('Home page', collection_listings.first.title)
  end

  def test_get_collection_listing
    fake("collection_listings/1", method: :get, status: 201, body: load_fixture('collection_listing'))

    collection_listing = ShopifyAPI::CollectionListing.find(1)

    assert_equal(1, collection_listing.collection_id)
    assert_equal('Home page', collection_listing.title)
  end

  def test_get_collection_listing_reload
    fake("collection_listings/1", method: :get, status: 201, body: load_fixture('collection_listing'))

    collection_listing = ShopifyAPI::CollectionListing.new(collection_id: 1)
    collection_listing.reload

    assert_equal(1, collection_listing.collection_id)
    assert_equal('Home page', collection_listing.title)
  end

  def test_get_collection_listing_product_ids
    fake(
      "collection_listings/1/product_ids",
      method: :get,
      status: 201,
      body: load_fixture('collection_listing_product_ids')
    )

    collection_listing = ShopifyAPI::CollectionListing.new(collection_id: 1)

    assert_equal([1, 2], collection_listing.product_ids)
  end

  def test_get_collection_listing_product_ids_multi_page_with_cursor
    version = ShopifyAPI::ApiVersion.find_version('2019-07')
    ShopifyAPI::Base.api_version = version.to_s

    collection_listing = ShopifyAPI::CollectionListing.new(collection_id: 1)

    url = "https://this-is-my-test-shop.myshopify.com/admin/api/2019-07/collection_listings/1/product_ids.json"

    next_page_info = "notarealpageinfobutthatsokay"
    next_page_url = "#{url}?page_info=#{next_page_info}"
    link_header = "<#{next_page_url}>; rel=\"next\""

    fake(
      "collection_listings/1/product_ids",
      method: :get,
      status: 201,
      url: url,
      body: load_fixture('collection_listing_product_ids'),
      link: link_header,
    )

    product_ids = collection_listing.product_ids
    assert_equal([1, 2], product_ids)
    assert(product_ids.next_page?)

    fake(
      "collection_listings/1/product_ids",
      method: :get,
      status: 201,
      url: next_page_url,
      body: load_fixture('collection_listing_product_ids2'),
      link: link_header,
    )

    next_page = product_ids.fetch_next_page
    assert_equal([3, 4], next_page)
  end
end
