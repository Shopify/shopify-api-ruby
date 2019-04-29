# frozen_string_literal: true
require 'test_helper'

class PublicationTest < Test::Unit::TestCase
  def test_find_all_publications
    fake 'publications'
    publications = ShopifyAPI::Publication.find(:all)

    assert_equal 55650051, publications.first.id
    assert_equal "Buy Button", publications.first.name
  end
end
