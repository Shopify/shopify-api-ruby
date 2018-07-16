module ShopifyAPI
  class DiscountCode < Base
    init_prefix :price_rule

    def price_rule_id
      @prefix_options[:price_rule_id]
    end
    
    def self.lookup(code)
      begin
        self.find(:one, from: '/admin/discount_codes/lookup.json?code=' + code)
      rescue ActiveResource::Redirection => ex
        self.find(:one, from: ex.response['Location'])
      end
    end
  end
end
