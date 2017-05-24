require 'test_helper'

class PriceRuleTest < Test::Unit::TestCase
  test 'get should get a price_rule' do
    fake 'price_rules/456', method: :get, status: 200, body: load_fixture('price_rule')

    price_rule = ShopifyAPI::PriceRule.find(456)
    assert_equal "456", price_rule.id
  end

  test 'get should get all price_rules' do
    fake 'price_rules', method: :get, status: 200, body: load_fixture('price_rules')

    price_rules = ShopifyAPI::PriceRule.all
    assert_equal 'line_items', price_rules.first.target_type
  end

  test 'create should create a price_rule' do
    fake 'price_rules', method: :post, status: 201, body: load_fixture('price_rule')

    price_rule = ShopifyAPI::PriceRule.create(target_type: 'line_items', value_type: 'percentage')
    assert_equal 'line_items', price_rule.target_type
  end

  test 'delete should delete price_rule' do
    fake 'price_rules/456', method: :get, status: 200, body: load_fixture('price_rule')
    fake 'price_rules/456', method: :delete, status: 200, body: 'destroyed'

    price_rule = ShopifyAPI::PriceRule.find(456)
    assert price_rule.destroy
  end
end
