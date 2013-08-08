module ShopifyAPI
  class CustomerSavedSearch < Base
    has_many :customers, :class_name => ShopifyAPI::Customer
  end
end
