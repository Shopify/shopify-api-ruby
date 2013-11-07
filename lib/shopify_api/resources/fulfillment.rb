module ShopifyAPI
  class Fulfillment < Base
    self.prefix = "/admin/orders/:order_id/"

    def cancel; load_attributes_from_response(post(:cancel, {}, only_id)); end
    def complete; load_attributes_from_response(post(:complete, {}, only_id)); end
  end
end
