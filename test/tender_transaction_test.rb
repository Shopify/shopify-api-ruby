# frozen_string_literal: true

require 'test_helper'

class TenderTransactionTest < Test::Unit::TestCase
  def setup
    super
    fake("tender_transactions", method: :get, body: load_fixture('tender_transactions'))
  end

  context "Tender Transaction" do
    should 'return a list of transactions' do
      tender_transactions = ShopifyAPI::TenderTransaction.all
      assert_equal(3, tender_transactions.length)
      assert_equal([1, 2, 3], tender_transactions.map(&:id))
    end
  end
end
