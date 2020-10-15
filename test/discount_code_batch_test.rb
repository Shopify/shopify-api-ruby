# frozen_string_literal: true
require 'test_helper'

class DiscountCodeBatchTest < Test::Unit::TestCase
  def setup
    super
    fake('price_rules/102586120/batch/989355119', body: load_fixture('discount_code_batch'))
  end

  def test_get_batch
    batch = ShopifyAPI::DiscountCodeBatch.find(989355119, params: { price_rule_id: 102586120 })

    assert_equal(989355119, batch.id)
  end

  def test_get_batch_discount_codes
    fake('price_rules/102586120/batch/989355119/discount_codes',
      method: :get,
      status: 200,
      body: load_fixture('discount_code_batch_discount_codes'))

    batch = ShopifyAPI::DiscountCodeBatch.find(989355119, params: { price_rule_id: 102586120 })
    discount_code_job = batch.discount_code_job

    assert_equal(3, discount_code_job.count)
    assert(discount_code_job[2].errors.present?)
  end

  def test_create_batch
    fake('price_rules/102586120/batch', method: :post, status: 201, body: load_fixture('discount_code_batch'))
    batch = ShopifyAPI::DiscountCodeBatch.new
    batch.prefix_options[:price_rule_id] = 102586120
    discount_codes = [{ "code": "SUMMER1" }, { "code": "SUMMER2" }, { "code": "SUMMER3" }]
    batch.discount_codes = discount_codes
    batch.save

    expected_body = { discount_codes: discount_codes }.to_json
    assert_equal(expected_body, WebMock.last_request.body)
  end
end
