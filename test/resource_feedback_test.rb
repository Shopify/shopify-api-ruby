# frozen_string_literal: true
class ResourceFeedbackTest < Test::Unit::TestCase
  def test_get_resource_feedback
    body = { resource_feedback: [ { resource_type: 'Shop' } ] }.to_json
    fake('resource_feedback', method: :get, body: body)
    resource_feedback = ShopifyAPI::ResourceFeedback.find(:all)
    assert_equal('Shop', resource_feedback.first.resource_type)
  end

  def test_save_with_resource_feedback_endpoint
    body = { resource_feedback: {} }.to_json
    fake('resource_feedback', method: :post, body: body)
    ShopifyAPI::ResourceFeedback.new.save
    assert_request_body(body)
  end

  def test_get_resource_feedback_with_product_id
    body = { resource_feedback: [ { resource_type: 'Product' } ] }.to_json
    fake('products/42/resource_feedback', method: :get, body: body)
    resource_feedback = ShopifyAPI::ResourceFeedback.find(:all, params: { product_id: 42 })
    assert_equal('Product', resource_feedback.first.resource_type)
  end

  def test_save_with_product_id_resource_feedback_endpoint
    body = { resource_feedback: {} }.to_json
    fake('products/42/resource_feedback', method: :post, body: body)
    ShopifyAPI::ResourceFeedback.new(product_id: 42).save
    assert_request_body(body)
  end

  def test_save_raises_exception_when_already_persisted
    body = { resource_feedback: {} }.to_json
    fake('resource_feedback', method: :post, body: body)
    resource_feedback = ShopifyAPI::ResourceFeedback.new
    resource_feedback.save
    assert_request_body(body)

    ShopifyAPI::ResourceFeedback.any_instance.expects(:persisted?).returns(true)
    assert_raises(ShopifyAPI::ResourceFeedback::ExistingFeedbackSaved) do
      resource_feedback.save
    end
  end
end
