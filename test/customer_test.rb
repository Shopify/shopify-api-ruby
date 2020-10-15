require 'test_helper'

class CustomerTest < Test::Unit::TestCase
  def setup
    super

    fake('customers/207119551', body: load_fixture('customers'))

    @customer = ShopifyAPI::Customer.find(207119551)
  end

  test "search should get a customers collection" do
    fake "customers/search.json?query=Bob+country%3AUnited+States", extension: false, body: load_fixture('customers_search')

    results = ShopifyAPI::Customer.search(query: 'Bob country:United States')
    assert_equal 'Bob', results.first.first_name
  end

  test "account_activation_url should create an account activation url" do
    fake "customers/207119551/account_activation_url", method: :post, body: load_fixture('customers_account_activation_url')

    activation_url = "http://apple.myshopify.com/account/activate/207119551/86688abf23572680740b1c062fa37111-1458248616"
    assert_equal activation_url, @customer.account_activation_url
  end

  test "#send_invite with no params" do
    customer_invite_fixture = load_fixture('customer_invite')
    customer_invite = ActiveSupport::JSON.decode(customer_invite_fixture)
    fake 'customers/207119551/send_invite', method: :post, body: customer_invite_fixture

    customer_invite_response = @customer.send_invite

    assert_equal '{"customer_invite":{}}', WebMock.last_request.body
    assert_kind_of ShopifyAPI::CustomerInvite, customer_invite_response
    assert_equal customer_invite['customer_invite']['to'], customer_invite_response.to
  end

  test "#send_invite with params" do
    customer_invite_fixture = load_fixture('customer_invite')
    customer_invite = ActiveSupport::JSON.decode(customer_invite_fixture)
    fake 'customers/207119551/send_invite', method: :post, body: customer_invite_fixture


    customer_invite_response = @customer.send_invite(ShopifyAPI::CustomerInvite.new(customer_invite['customer_invite']))

    assert_equal customer_invite, ActiveSupport::JSON.decode(WebMock.last_request.body)
    assert_kind_of ShopifyAPI::CustomerInvite, customer_invite_response
    assert_equal customer_invite['customer_invite']['to'], customer_invite_response.to
  end
end
