

require 'test_helper'

class CheckoutsTest < Test::Unit::TestCase
  test "current should get current checkout settings for shop" do
    fake 'settings/checkout', :method => :get, :status => 200, :body => load_fixture('checkout_settings')
    checkout_configuration = ShopifyAPI::CheckoutSettings.current
    assert_equal checkout_configuration.abandoned_checkout_email_time_delay, 2
    assert_equal checkout_configuration.auto_fulfill_risky_orders, false
    assert_equal checkout_configuration.confirmation_page, 'thanks!'
    assert_equal checkout_configuration.email_marketing_mode, 'unchecked'
    assert_equal checkout_configuration.notify_customers, false
    assert_equal checkout_configuration.order_closing, 'auto'
    assert_equal checkout_configuration.same_billing_and_shipping_address, true
    assert_equal checkout_configuration.shipping_behaviour, 'manual'
  end

  test "save should set checkout settings for shop" do
    fake 'settings/checkout', :method => :get, :status => 200, :body => load_fixture('checkout_settings')
    fake "settings//checkout", :method => :put, :body => load_fixture('checkout_settings_updated')
    checkout_configuration = ShopifyAPI::CheckoutSettings.current

    checkout_configuration.shipping_behaviour = 'auto'
    checkout_configuration.save

    assert_equal checkout_configuration.shipping_behaviour, 'auto'
  end
end
