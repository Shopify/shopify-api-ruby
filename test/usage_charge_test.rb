require 'test_helper'

class UsageChargeTest < Test::Unit::TestCase
  def test_create_usage_charge
    fake "recurring_application_charges/654381177/usage_charges", method: :post, body: load_fixture('usage_charge')

    usage_charge = ShopifyAPI::UsageCharge.new(description: '1000 emails', price: 1.0)
    usage_charge.prefix_options = {recurring_application_charge_id: 654381177}
    assert usage_charge.save
  end

  def test_get_usage_charges
    fake "recurring_application_charges/654381177/usage_charges", method: :get, body: load_fixture('usage_charges')
    usage_charges = ShopifyAPI::UsageCharge.find(:all, params: {recurring_application_charge_id: 654381177})

    assert_equal 2, usage_charges.size
  end

  def test_get_usage_charge
    fake "recurring_application_charges/654381177/usage_charges/359376002", method: :get, body: load_fixture('usage_charge')
    usage_charge = ShopifyAPI::UsageCharge.find(359376002, params: {recurring_application_charge_id: 654381177})

    assert_equal 359376002, usage_charge.id
  end
end
