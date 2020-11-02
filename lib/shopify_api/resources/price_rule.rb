# frozen_string_literal: true
module ShopifyAPI
  class PriceRule < Base
    def discount_codes
      DiscountCode.find(:all, params: { price_rule_id: id })
    end
  end
end
