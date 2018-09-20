module ShopifyAPI
  class DiscountCodeBatch < Base
    init_prefix :price_rule

    self.collection_name = 'batch'

    def price_rule_id
      @prefix_options[:price_rule_id]
    end

    def discount_code_job
      @discount_codes ||= begin
        if id
          path = "/admin/price_rules/#{price_rule_id}/batch/#{id}/discount_codes.json"
          ShopifyAPI::DiscountCode.find :all, from: path
        end
      end
    end

    def encode(options = {})
      send("to_#{self.class.format.extension}", options)
    end
  end
end
