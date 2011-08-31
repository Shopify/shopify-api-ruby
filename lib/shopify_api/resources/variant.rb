module ShopifyAPI
  class Variant < Base
    include Metafields

    self.prefix = "/admin/products/:product_id/"
    
    def self.prefix(options={})
      options[:product_id].nil? ? "/admin/" : "/admin/products/#{options[:product_id]}/"
    end
  end
end
