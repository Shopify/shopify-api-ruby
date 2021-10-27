# typed: true
# frozen_string_literal: true

require_relative "../test_helper"

class FileSessionStorageTest < Minitest::Test
  def setup
    @session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop")
    @storage = ShopifyAPI::Auth::FileSessionStorage.new
  end

  def test_store_session
    assert(@storage.store_session(@session))
  end

  def test_load_session
    @storage.store_session(@session)
    loaded_session = @storage.load_session(@session.id)
    assert_equal(@session.id, loaded_session.id)
  end

  def test_delete_session
    @storage.store_session(@session)
    assert(@storage.delete_session(@session.id))
    assert_nil(@storage.load_session(@session.id))
  end
end
