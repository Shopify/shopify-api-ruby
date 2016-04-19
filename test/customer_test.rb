require 'test_helper'

class CustomerTest < Test::Unit::TestCase

  test "search should get a customers collection" do
    fake "customers/search.json?query=Bob+country%3AUnited+States", :extension => false, :body => load_fixture('customers_search')

    results = ShopifyAPI::Customer.search(query: 'Bob country:United States')
    assert_equal 'Bob', results.first.first_name
  end

  test "account_activation_url should create an account activation url" do
    fake "customers/207119551", :body => load_fixture('customers')
    fake "customers/207119551/account_activation_url", :method => :post, :body => load_fixture('customers_account_activation_url')

    customer = ShopifyAPI::Customer.find(207119551)
    activation_url = "http://apple.myshopify.com/account/activate/207119551/86688abf23572680740b1c062fa37111-1458248616"
    assert_equal activation_url, customer.account_activation_url
  end
end
