# frozen_string_literal: true
require 'test_helper'

class CollectionPublicationTest < Test::Unit::TestCase
  def test_get_all_collection_publications
    fake 'publications/55650051/collection_publications', body: load_fixture('collection_publications')
    collection_publications = ShopifyAPI::CollectionPublication.find(:all, params: { publication_id: 55650051 })

    assert_equal 96062799894, collection_publications.first.id
    assert_equal 55650051, collection_publications.first.publication_id
  end

  def test_get_collection_publication
    fake 'publications/55650051/collection_publications/647162527768', body: load_fixture('collection_publication')
    collection_publication = ShopifyAPI::CollectionPublication.find(647162527768, params: { publication_id: 55650051 })

    assert_equal 96062799894, collection_publication.id
    assert_equal 55650051, collection_publication.publication_id
  end

  def test_create_collection_publication
    fake 'publications/55650051/collection_publications', method: :post, body: load_fixture('collection_publication')
    ShopifyAPI::CollectionPublication.create(
      publication_id: 55650051,
      published_at: "2018-01-29T14:06:08-05:00",
      published: true,
      collection_id: 8267093571
    )

    expected_body = {
      collection_publication: {
        published_at: "2018-01-29T14:06:08-05:00",
        published: true,
        collection_id: 8267093571,
      },
    }.to_json

    assert_equal expected_body, WebMock.last_request.body
  end
end
