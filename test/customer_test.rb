require 'test_helper'

class CustomerTest < Test::Unit::TestCase
  def test_search
    fake "customers/search.json?query=Bob+country%3AUnited+States", extension: false, body: load_fixture('customers_search')

    results = ShopifyAPI::Customer.search(query: 'Bob country:United States')
    assert_equal 'Bob', results.first.first_name
  end
end
