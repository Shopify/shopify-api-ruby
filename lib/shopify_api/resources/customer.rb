module ShopifyAPI
  class Customer < Base
    include Metafields

    def orders
      Order.find(:all, params: {customer_id: self.id})
    end

    def self.search(params)
      find(:all, from: :search, params: params)
    end
  end
end
