require 'test_helper'

class PriceRuleTest < Test::Unit::TestCase
  def setup
    super
    fake 'price_rules/102586120', body: load_fixture('price_rule')

    @price_rule = ShopifyAPI::PriceRule.find(102586120)
  end

  def test_get_price_rule
    fake 'price_rules/102586120', method: :get, status: 200, body: load_fixture('price_rule')
    price_rule = ShopifyAPI::PriceRule.find(102586120)

    assert_equal 102586120, price_rule.id
  end

  def test_get_all_price_rules
    fake 'price_rules', method: :get, status: 200, body: load_fixture('price_rules')
    price_rules = ShopifyAPI::PriceRule.all

    assert_equal 1, price_rules.length
    assert_equal 102586120, price_rules.first.id
  end

  def test_get_all_discount_codes_for_a_price_rule
    fake 'price_rules/102586120/discount_codes', method: :get, status: 200, body: load_fixture('discount_codes')
    price_rule = ShopifyAPI::PriceRule.find(102586120)

    assert_equal "SUMMERSALE10", price_rule.discount_codes.first.code
  end

  def test_create_price_rule
    fake 'price_rules', method: :post, status: 201, body: load_fixture('price_rule')

    price_rule = ShopifyAPI::PriceRule.create(
      target_type: "line_item",
      allocation_method: "across",
      value_type: "fixed_amount",
      value: -10.0,
      customer_selection: "all",
      starts_at: "2017-01-19T00:00:00Z"
    )

    assert_equal '{"price_rule":{"target_type":"line_item","allocation_method":"across","value_type":"fixed_amount","value":-10.0,"customer_selection":"all","starts_at":"2017-01-19T00:00:00Z"}}', WebMock.last_request.body
    assert_equal -10, price_rule.value
  end

  def test_update_price_rule
    price_rule_response = ActiveSupport::JSON.decode(load_fixture('price_rule'))
    price_rule_response['price_rule']['value'] = -50.0
    @price_rule.value = -50.0
    fake 'price_rules/102586120', method: :put, status: 200, body: ActiveSupport::JSON.encode(price_rule_response)

    @price_rule.save

    assert_equal price_rule_response['price_rule']['value'], @price_rule.value
  end

  def test_delete_price_rule
    fake 'price_rules/102586120', method: :delete, body: 'destroyed'

    assert @price_rule.destroy
  end
end
