module ShopifyAPI
  class GiftCard < Base
    include Events

    def disable
      load_attributes_from_response(post(:disable))
    end

    def send_code_email
      post(:send_code_email, {}, only_id)
    end
  end
end
