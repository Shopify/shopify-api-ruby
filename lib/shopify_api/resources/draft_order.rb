# Sample request params:
#
#new {}
#build {"draft_order"=>{"line_items"=>{"0"=>{"quantity"=>nil, "variant_id"=>4}}, "applied_discount"=>nil, "shipping_address"=>{}, "email"=>"", "note"=>"", "tax_exempt"=>"false", "shipping_line"=>{}}, "protocol"=>"https://", "controller"=>"admin/draft_orders", "action"=>"build"}
#create {"draft_order"=>{"line_items"=>{"0"=>{"quantity"=>1, "price"=>"1447.99", "variant_id"=>"4", "title"=>"Practical Steel Table", "variant_title"=>"Violet", "taxable"=>"true", "gift_card"=>"false", "requires_shipping"=>"false", "applied_discount"=>nil, "custom"=>"false"}}, "applied_discount"=>nil, "shipping_address"=>{}, "email"=>"", "note"=>"", "tax_exempt"=>"false", "shipping_line"=>{}}, "no_flash"=>false, "protocol"=>"https://", "controller"=>"admin/draft_orders", "action"=>"create"}
#show {"protocol"=>"https://", "controller"=>"admin/draft_orders", "action"=>"show", "id"=>"1"}

module ShopifyAPI
  class DraftOrder < Base
    def new
      super.get(:new)
    end

    def build(params)
      self.update(params).post(:build)
    end

    def create(params)
      self.create(params).post(:create)
    end
  end
end