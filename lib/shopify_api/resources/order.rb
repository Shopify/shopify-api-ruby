module ShopifyAPI
  class Order < Base
    include Events
    include Metafields

    def close;  load_attributes_from_response(post(:close, {}, only_id)); end
    def open;   load_attributes_from_response(post(:open, {}, only_id)); end

    def cancel(options = {})
      load_attributes_from_response(post(:cancel, {}, options.to_json))
    end

    def transactions
      Transaction.find(:all, :params => { :order_id => id })
    end

    def capture(amount = "")
      Transaction.create(:amount => amount, :kind => "capture", :order_id => id)
    end

    class ClientDetails < Base
    end
  end
end
