require 'test_helper'

class DiscountTest < Test::Unit::TestCase
  test 'get should get a discount' do
    fake 'discounts/680866', method: :get, status: 200, body: load_fixture('discount')
    
    discount = ShopifyAPI::Discount.find(680866)
    assert_equal 680866, discount.id
  end
  
  test 'get should get all discounts' do
    fake 'discounts', method: :get, status: 200, body: load_fixture('discounts')
    
    discounts = ShopifyAPI::Discount.all
    assert_equal 'TENOFF', discounts.first.code
  end
  
  test 'create should create a discount' do
    fake 'discounts', method: :post, status: 201, body: load_fixture('discount')
    
    discount = ShopifyAPI::Discount.create(code: 'TENOFF', discount_type: 'percentage')
    assert_equal 'TENOFF', discount.code
  end
  
  test 'should disable discount' do
    fake 'discounts/680866', method: :get, status: 200, body: load_fixture('discount')
    fake 'discounts/680866/disable', method: :post, status: 201, body: load_fixture('discount_disabled')
    
    discount = ShopifyAPI::Discount.find(680866)
    discount.disable
    
    assert_equal "disabled", discount.status
  end
  
  test 'should enable discount' do
    fake 'discounts/680866', method: :get, status: 200, body: load_fixture('discount')
    fake 'discounts/680866/enable', method: :post, status: 201, body: load_fixture('discount')
    
    discount = ShopifyAPI::Discount.find(680866)
    discount.enable
    
    assert_equal "enabled", discount.status
  end
  
  test 'delete should delete discount' do
    fake 'discounts/680866', method: :get, status: 200, body: load_fixture('discount')
    fake 'discounts/680866', method: :delete, status: 200, body: 'destroyed'
    
    discount = ShopifyAPI::Discount.find(680866)
    assert discount.destroy
  end
end
