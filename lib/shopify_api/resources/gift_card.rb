module ShopifyAPI
  class GiftCard < Base
    class Adjustment < Base
      init_prefix :gift_card
    end

    def disable
      load_attributes_from_response(post(:disable))
    end
  end
end
