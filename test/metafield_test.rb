require 'test_helper'

class MetafieldTest < Test::Unit::TestCase
  def test_get_metafields
    fake("metafields", method: :get, body: load_fixture('metafields'))
    ShopifyAPI::Metafield.find(:all)
  end

  def test_get_metafield
    fake("metafields/721389482", method: :get, body: load_fixture('metafield'))
    assert(ShopifyAPI::Metafield.find(721389482))
  end

  def test_get_metafield_of_a_blog
    fake("blogs/1008414260/metafields/721389482", method: :get, body: load_fixture('metafield'))
    metafield = ShopifyAPI::Metafield.find(721389482, params: { resource: "blogs", resource_id: 1008414260 })
    assert_equal(1008414260, metafield.prefix_options[:resource_id])
  end

  def test_create_metafield_for_a_blog
    fake("blogs/1008414260", method: :get, body: load_fixture('blog'))
    fake("blogs/1008414260/metafields", method: :post, status: 201, body: load_fixture('metafield'))

    blog = ShopifyAPI::Blog.find(1008414260)
    metafield = blog.add_metafield(ShopifyAPI::Metafield.new(namespace: "summaries", key: "First Summary", value: "Make commerce better", value_type: "string"))

    assert_equal(ActiveSupport::JSON.decode('{"metafield":{"namespace":"summaries","key":"First Summary","value":"Make commerce better","value_type":"string"}}'), ActiveSupport::JSON.decode(WebMock.last_request.body))
    assert(!metafield.new_record?)
  end

  def test_update_metafield
    fake("metafields/721389482", method: :get, body: load_fixture('metafield'))
    fake("metafields/721389482", method: :put, status: 200, body: load_fixture('metafield'))
    metafield = ShopifyAPI::Metafield.find(721389482)
    metafield.namespace = "teaser"
    assert(metafield.save)
  end

  def test_delete_metafield
    fake("metafields/721389482", method: :get, body: load_fixture('metafield'))
    fake("metafields/721389482", method: :delete, body: 'destroyed')
    metafield = ShopifyAPI::Metafield.find(721389482)
    assert(metafield.destroy)
  end
end
