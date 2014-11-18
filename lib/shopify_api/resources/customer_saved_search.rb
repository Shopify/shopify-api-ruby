require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    def customers(params = {})
      Customer.search(params.merge({:saved_search_id => self.id}))
    end
  end
end
