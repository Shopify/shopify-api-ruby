# frozen_string_literal: true

require 'test_helper'

class CollectionTest < Test::Unit::TestCase
  def setup
    super

    fake_count
  end

  test 'ShopifyAPI::Base::collection_parser' do
    next if ActiveResource::VERSION::MAJOR < 4

    assert_equal ShopifyAPI::Base.collection_parser, ShopifyAPI::Collection
  end

  test '#current_page' do
    fake_first_page
    assert_equal 1, fetch.current_page

    fake_page2
    assert_equal 2, fetch(page: 2).current_page
  end

  test '#first_page?' do
    fake_first_page
    assert fetch.first_page?

    fake_page2
    refute fetch(page: 2).first_page?
  end

  test '#last_page?' do
    fake_first_page
    refute fetch.last_page?

    fake_last_page
    assert fetch(page: 3).last_page?
  end

  test '#limit' do
    fake_first_page
    assert_equal 50, fetch.limit

    fake_limit25
    assert_equal 25, fetch(limit: 25).limit
  end

  test '#next_page' do
    fake_page2
    assert_equal 3, fetch(page: 2).next_page

    fake_last_page
    assert_nil fetch(page: 3).next_page
  end

  test '#prev_page' do
    fake_last_page
    assert_equal 2, fetch(page: 3).prev_page

    fake_first_page
    assert_nil fetch.prev_page
  end

  test '#total_count' do
    fake_first_page
    assert_equal 127, fetch.total_count

    fake_page2
    assert_equal 127, fetch(page: 2).total_count

    fake_limit25
    assert_equal 127, fetch(limit: 25).total_count
  end

  test '#total_pages' do
    fake_count

    fake_first_page
    assert_equal 3, fetch.total_pages

    fake_limit25
    assert_equal 6, fetch(limit: 25).total_pages
  end

  private

  def fake_count
    body = { count: 127 }.to_json

    fake 'products/count', body: body
  end

  def fake_first_page
    body = fake_products[1..50].to_json

    fake :products, url: products_url, body: body
  end

  def fake_page2
    body = fake_products[51..101].to_json

    fake :products, url: products_url(page: 2), body: body
  end

  def fake_last_page
    body = fake_products[77..127].to_json

    fake :products, url: products_url(page: 3), body: body
  end

  def fake_limit25
    body = fake_products[1..25].to_json

    fake :products, url: products_url(limit: 25), body: body
  end

  def fake_products
    @fake_products ||= Array.new(127).map { |index| { id: index } }
  end

  def fetch(params = {})
    options = params.empty? ? {} : { params: params }

    ShopifyAPI::Product.all(options)
  end

  def products_url(params = {})
    endpoint = 'products.json'

    query = params.empty? ? '' : "?#{params.to_query}"

    "https://this-is-my-test-shop.myshopify.com/admin/#{endpoint}#{query}"
  end
end
