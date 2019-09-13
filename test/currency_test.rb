
# frozen_string_literal: true
require 'test_helper'
class CurrencyTest < Test::Unit::TestCase
  def setup
    super
    fake "currencies", method: :get, body: load_fixture('currencies')
  end

  context "Currency" do
    should 'return a list of enabled currencies' do
      currencies = ShopifyAPI::Currency.all
      assert_equal 4, currencies.count
      assert_equal %w(AUD EUR GBP HKD), currencies.map(&:currency)
      assert_equal [true, true, true, false], currencies.map(&:enabled)
      currencies.each do |currency|
        assert_equal "2018-10-03T14:44:08-04:00", currency.rate_updated_at
      end
    end
  end
end
