require 'test_helper'

class RecurringApplicationChargeTest < Test::Unit::TestCase
  context "#all" do
    should "get all charges" do
      fake "recurring_application_charges"

      charges = ShopifyAPI::RecurringApplicationCharge.all
      assert_equal "Super Duper Plan", charges.first.name
    end
  end


  should "not fail when there are no charges" do
    fake "recurring_application_charges", body: {recurring_application_charges: []}.to_json

    assert_equal 0, ShopifyAPI::RecurringApplicationCharge.all.count
    assert_equal nil, ShopifyAPI::RecurringApplicationCharge.current
    assert_equal [], ShopifyAPI::RecurringApplicationCharge.pending
  end
end
