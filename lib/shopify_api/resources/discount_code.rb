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
        r = self.find(:one, from: ex.response['Location'])
        if !r.nil?
          r.prefix_options[:price_rule_id] = /price_rules\/([0-9]+)/.match(ex.response['Location'])[1].to_i
        end
        r
      end
    end
  end
end
