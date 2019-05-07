# frozen_string_literal: true

module ShopifyAPI
  class Collection < Base
    include Events
    include Metafields

    def products(options = {})
      binding.pry
      binding.pry
      url = "#{self.class.prefix}collections/#{id}/products.json"
      puts url
      Product.find(:all, from: url, params: options)
    end
  end
end
