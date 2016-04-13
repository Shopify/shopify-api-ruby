module ShopifyAPI
  class Fulfillment < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def cancel; load_attributes_from_response(post(:cancel, {}, only_id)); end
    def complete; load_attributes_from_response(post(:complete, {}, only_id)); end
    def open; load_attributes_from_response(post(:open, {}, only_id)); end
  end
end
