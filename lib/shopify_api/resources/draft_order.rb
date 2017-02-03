module ShopifyAPI
  class DraftOrder < Base
    include Metafields

    def send_invoice(draft_order_invoice = ShopifyAPI::DraftOrderInvoice.new)
      resource = post(:send_invoice, {}, draft_order_invoice.encode)
      ShopifyAPI::DraftOrderInvoice.new(ShopifyAPI::DraftOrder.format.decode(resource.body))
    end
  end
end
