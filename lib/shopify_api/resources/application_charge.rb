module ShopifyAPI
  class ApplicationCharge < Base
    undef_method :test

    def activate
      load_attributes_from_response(post(:activate))
    end
  end
end
