# frozen_string_literal: true
module ShopifyAPI
  class DiscountCode < Base
    init_prefix :price_rule

    def price_rule_id
      @prefix_options[:price_rule_id]
    end
  end
end
