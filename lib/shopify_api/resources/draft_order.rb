# frozen_string_literal: true
module ShopifyAPI
  class DraftOrder < Base
    include Metafields

    def send_invoice(draft_order_invoice = ShopifyAPI::DraftOrderInvoice.new)
      resource = post(:send_invoice, {}, draft_order_invoice.encode)
      ShopifyAPI::DraftOrderInvoice.new(ShopifyAPI::DraftOrder.format.decode(resource.body))
    end

    def complete(options = {})
      load_attributes_from_response(put(:complete, options, nil))
    end
  end
end
