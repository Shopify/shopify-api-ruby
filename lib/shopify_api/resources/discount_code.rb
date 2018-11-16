module ShopifyAPI
  class DiscountCode < Base
    init_prefix :price_rule

    def price_rule_id
      @prefix_options[:price_rule_id]
    end

    def self.lookup(code)
      find(:one, from: '/admin/discount_codes/lookup.json?code=' + code)
    rescue ActiveResource::Redirection => ex
      location = ex.response['Location']
      r = find(:one, from: location)
      unless r.nil?
        r.prefix_options[:price_rule_id] = %r{price_rules/([0-9]+)}.match(location)[1].to_i
      end
      r
    end
  end
end
