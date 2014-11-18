require 'test_helper'

class CustomerSavedSearchTest < Test::Unit::TestCase
  def setup
    super
    load_customer_saved_search
  end

  def test_get_customers_from_customer_saved_search
    fake 'customers/search.json?saved_search_id=8899730', :body => load_fixture('customer_saved_search_customers'), :extension => false
    assert_equal 1, @customer_saved_search.customers.length
    assert_equal 112223902, @customer_saved_search.customers.first.id
  end

  def test_get_customers_from_customer_saved_search_with_params
    fake 'customers/search.json?saved_search_id=8899730&limit=1', :body => load_fixture('customer_saved_search_customers'), :extension => false
    customers = @customer_saved_search.customers(:limit => 1)
    assert_equal 1, customers.length
    assert_equal 112223902, customers.first.id
  end

  private
  def load_customer_saved_search
    fake 'customer_saved_searches/8899730', :body => load_fixture('customer_saved_search')
    @customer_saved_search = ShopifyAPI::CustomerSavedSearch.find(8899730)
  end
end
