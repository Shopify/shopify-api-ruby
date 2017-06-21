module ShopifyAPI
  class CustomerAddress < Base
    init_prefix :customer
    self.element_name = "address"

    def make_default
      put(:default)
    end

    def self.set(customer, ids, operation)
      put(:set, customer_id: customer.id, address_ids: ids, operation: operation)
    end
  end
end