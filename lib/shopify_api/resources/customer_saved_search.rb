require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    def customers(params = {})
      url = "/admin/customer_saved_searches/#{id}/customers.json"
      Customer.find(:all, from: url, params: params)
    end
  end
end
