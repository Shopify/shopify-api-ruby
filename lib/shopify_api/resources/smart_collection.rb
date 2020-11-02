# frozen_string_literal: true
module ShopifyAPI
  class SmartCollection < Base
    include Events
    include Metafields

    def products
      Product.find(:all, params: { collection_id: id })
    end

    def order(options = {})
      load_attributes_from_response(put(:order, options, only_id))
    end
  end
end
