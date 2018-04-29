# frozen_string_literal: true

require 'test_helper'

class CollectionTest < Test::Unit::TestCase
  def setup
    super

    fake 'products/count', body: { count: 127 }.to_json
    fake :products, url: products_url, body: first_page.to_json
    fake :products, url: products_url(page: 2), body: page2.to_json
    fake :products, url: products_url(page: 3), body: last_page.to_json
    fake :products, url: products_url(limit: 25), body: limit25.to_json
  end

  test 'ShopifyAPI::Base::collection_parser' do
    assert_equal ShopifyAPI::Base.collection_parser, ShopifyAPI::Collection
  end

  test '#current_page' do
    assert_equal 1, fetch.current_page
    assert_equal 2, fetch(page: 2).current_page
  end

  test '#first_page?' do
    assert fetch.first_page?
    refute fetch(page: 2).first_page?
  end

  test '#last_page?' do
    refute fetch.last_page?
    assert fetch(page: 3).last_page?
  end

  test '#limit' do
    assert_equal 50, fetch.limit
    assert_equal 25, fetch(limit: 25).limit
  end

  test '#next_page' do
    assert_equal 3, fetch(page: 2).next_page
    assert_nil fetch(page: 3).next_page
  end

  test '#prev_page' do
    assert_equal 2, fetch(page: 3).prev_page
    assert_nil fetch.prev_page
  end

  test '#total_count' do
    assert_equal 127, fetch.total_count
    assert_equal 127, fetch(page: 2).total_count
    assert_equal 127, fetch(limit: 25).total_count
  end

  test '#total_pages' do
    assert_equal 3, fetch.total_pages
    assert_equal 6, fetch(limit: 25).total_pages
  end

  private

  def fake_products
    @fake_products ||= 127.times.map { |index| { id: index } }
  end

  def fetch(params = {})
    options = params.empty? ? {} : { params: params }

    ShopifyAPI::Product.all(options)
  end

  def first_page
    @page1 ||= fake_products[1..50]
  end

  def last_page
    @last_page ||= fake_products[77..127]
  end

  def limit25
    @limit25 = fake_products[1..25]
  end

  def page2
    @page2 ||= fake_products[51..101]
  end

  def products_url(params = {})
    endpoint = 'products.json'

    query = params.empty? ? '' : "?#{params.to_query}"

    "https://this-is-my-test-shop.myshopify.com/admin/#{endpoint}#{query}"
  end
end
