# frozen_string_literal: true

require 'test_helper'

class TenderTransactionTest < Test::Unit::TestCase
  def setup
    super
    fake "/tender_transactions.json", method: :get, body: load_fixture('tender_transactions')
  end

  context "Tender Transaction" do
    should 'return a list of transactions' do
      tender_transactions = ShopifyAPI::TenderTransaction.all
    end
  end
end
