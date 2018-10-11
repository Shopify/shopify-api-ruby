module ShopifyAPI
  class SmartCollection < Base
    include Events
    include Metafields

    def products(options = {})
      if options.present?
        Product.find(:all, from: "/admin/smart_collections/#{id}/products.json", params: options)
      else
        Product.find(:all, params: { collection_id: id })
      end
    end

    def order(options={})
      load_attributes_from_response(put(:order, options, only_id))
    end

  end
end
