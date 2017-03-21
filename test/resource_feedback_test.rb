class ResourceFeedbackTest < Test::Unit::TestCase
  def test_save_with_resource_feedbacks_endpoint
    body = { resource_feedback: {} }.to_json
    fake 'resource_feedbacks', method: :post, body: body
    ShopifyAPI::ResourceFeedback.new.save
    assert_request_body body
  end

  def test_save_with_product_id_resource_feedbacks_endpoint
    body = { resource_feedback: {} }.to_json
    fake 'products/42/resource_feedbacks', method: :post, body: body
    ShopifyAPI::ResourceFeedback.new(product_id: 42).save
    assert_request_body body
  end

  def test_save_raises_exception_when_already_persisted
    body = { resource_feedback: {} }.to_json
    fake 'resource_feedbacks', method: :post, body: body
    resource_feedback = ShopifyAPI::ResourceFeedback.new
    resource_feedback.save
    assert_request_body body

    ShopifyAPI::ResourceFeedback.any_instance.expects(:persisted?).returns(true)
    assert_raises ShopifyAPI::ResourceFeedback::ExistingFeedbackSaved do
      resource_feedback.save
    end
  end
end
