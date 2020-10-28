# frozen_string_literal: true
require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    early_july_pagination_release!

    def customers(params = {})
      Customer.search(params.merge({ customer_saved_search_id: self.id }))
    end
  end
end
