require 'shopify_api/resources/customer'

module ShopifyAPI
  class CustomerSavedSearch < Base
    has_many :customers, :class_name => ShopifyAPI::Customer
  end
end
