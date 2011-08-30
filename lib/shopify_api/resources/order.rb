module ShopifyAPI
  class Order < Base
    def close;  load_attributes_from_response(post(:close, {}, only_id)); end
    def open;   load_attributes_from_response(post(:open, {}, only_id)); end

    def cancel(options = {})
      load_attributes_from_response(post(:cancel, options, only_id))
    end

    def transactions
      Transaction.find(:all, :params => { :order_id => id })
    end

    def capture(amount = "")
      Transaction.create(:amount => amount, :kind => "capture", :order_id => id)
    end

    def only_id
      encode(:only => :id, :include => [], :methods => [], :fields => [])
    end
  end
end
