module ShopifyAPI
  class DraftOrder < Base
    include Metafields

    def send_invoice(draft_order_invoice = ShopifyAPI::DraftOrderInvoice.new)
      response = post(:send_invoice, {}, draft_order_invoice.encode)
      load_attributes_from_response(response)
    end
  end
end
