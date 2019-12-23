# frozen_string_literal: true

module ShopifyAPI
  class Collection < Base
    include Events
    include Metafields

    def products(options = {})
      available_in_version = ShopifyAPI::ApiVersion.find_version('2020-01')
      raise NotImplementedError unless ShopifyAPI::Base.api_version >= available_in_version
      Product.find(:all, from: "#{self.class.prefix}collections/#{id}/products.json", params: options)
    end
  end
end
