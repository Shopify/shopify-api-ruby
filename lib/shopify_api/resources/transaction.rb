module ShopifyAPI
  class Transaction < Base
    self.prefix = "/admin/orders/:order_id/"
  end
end
