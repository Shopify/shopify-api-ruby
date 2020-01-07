module ShopifyAPI
  class FulfillmentOrder < Base
    def self.find(scope, *args)
      if scope == :all
        order_id = args.first&.dig(:params, :order_id)
        raise ShopifyAPI::ValidationException, "'order_id' is required" if order_id.blank?

        order = ::ShopifyAPI::Order.new(id: order_id)
        order.fulfillment_orders(args.first[:params].except(:order_id))
      else
        super(scope, *args)
      end
    end

    def fulfillments(options = {})
      fulfillment_hashes = get(:fulfillments, options)
      fulfillment_hashes.map { |fulfillment_hash| Fulfillment.new(fulfillment_hash) }
    end
  end
end
