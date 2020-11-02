# frozen_string_literal: true
require 'test_helper'

class ApplicationCreditTest < Test::Unit::TestCase
  def test_application_credit_create
    fake("application_credits", method: :post, status: 201, body: load_fixture('application_credit'))

    credit = ShopifyAPI::ApplicationCredit.create(
      description: "refund for application charge",
      amount: 5.00,
      api_client_id: 861378,
      shop_id: 487168
    )

    assert_equal('refund for application charge', credit.description)
    assert_equal('5.00', credit.amount)
  end

  def test_get_application_credit
    fake("application_credits/803742", method: :get, status: 201, body: load_fixture('application_credit'))

    credit = ShopifyAPI::ApplicationCredit.find(803742)

    assert_equal('refund for application charge', credit.description)
    assert_equal('5.00', credit.amount)
  end

  def test_list_application_credits
    fake("application_credits", method: :get, status: 201, body: load_fixture('application_credits'))

    credit = ShopifyAPI::ApplicationCredit.find(:all)

    assert_equal(2, credit.size)
    assert_equal('10.00', credit.last.amount)
  end
end
