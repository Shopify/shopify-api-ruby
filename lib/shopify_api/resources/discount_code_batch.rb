# frozen_string_literal: true
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
          path = self.class.api_version.construct_api_path(
            "price_rules/#{price_rule_id}/batch/#{id}/discount_codes.json"
          )
          discount_codes = ShopifyAPI::DiscountCode.find(:all, from: path)
          discount_codes.each do |code|
            errors = code.attributes['errors']
            errors.attributes.each do |key, values|
              values.each { |message| code.errors.add(key, message) }
            end
          end
          discount_codes
        end
      end
    end

    def encode(options = {})
      send("to_#{self.class.format.extension}", options)
    end
  end
end
