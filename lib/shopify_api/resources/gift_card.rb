# frozen_string_literal: true
module ShopifyAPI
  class GiftCard < Base
    def disable
      load_attributes_from_response(post(:disable))
    end
  end
end
