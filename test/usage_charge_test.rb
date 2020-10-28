# frozen_string_literal: true
require 'test_helper'

class UsageChargeTest < Test::Unit::TestCase

  def test_create_usage_charges
    fake("recurring_application_charges/654381177/usage_charges", method: :post, body: load_fixture('usage_charge'))

    usage_charge = ShopifyAPI::UsageCharge.new(description: '1000 emails', price: 1.0)
    usage_charge.prefix_options = { recurring_application_charge_id: 654381177 }
    assert(usage_charge.save)
  end

  def test_get_usage_charges
    fake(
      "recurring_application_charges/654381177/usage_charges/359376002",
      method: :get,
      status: 201,
      body: load_fixture('usage_charge')
    )

    usage_charge = ShopifyAPI::UsageCharge.find(359376002, params: { recurring_application_charge_id: 654381177 })

    assert_equal("1000 emails", usage_charge.description)
  end

end
