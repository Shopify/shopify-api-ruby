module ShopifyAPI
  class DiscountCode < Base
    include DisablePrefixCheck
    
    conditional_prefix :price_rule

    def price_rule_id
      @prefix_options[:price_rule_id]
    end

    def self.lookup(options = {})
      get :lookup, options
    end
  end
end
