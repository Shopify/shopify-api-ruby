# frozen_string_literal: true
require 'test_helper'

class ProductPublicationTest < Test::Unit::TestCase
  def test_get_all_product_publications
    fake('publications/55650051/product_publications', body: load_fixture('product_publications'))
    product_publications = ShopifyAPI::ProductPublication.find(:all, params: { publication_id: 55650051 })

    assert_equal(647162527768, product_publications.first.id)
    assert_equal(55650051, product_publications.first.publication_id)
  end

  def test_get_product_publication
    fake('publications/55650051/product_publications/647162527768', body: load_fixture('product_publication'))
    product_publication = ShopifyAPI::ProductPublication.find(647162527768, params: { publication_id: 55650051 })

    assert_equal(647162527768, product_publication.id)
    assert_equal(55650051, product_publication.publication_id)
  end

  def test_create_product_publication
    fake('publications/55650051/product_publications', method: :post, body: load_fixture('product_publication'))
    ShopifyAPI::ProductPublication.create(
      publication_id: 55650051,
      published_at: "2018-01-29T14:06:08-05:00",
      published: true,
      product_id: 8267093571
    )

    expected_body = {
      product_publication: {
        published_at: "2018-01-29T14:06:08-05:00",
        published: true,
        product_id: 8267093571,
      },
    }.to_json

    assert_equal(expected_body, WebMock.last_request.body)
  end
end
