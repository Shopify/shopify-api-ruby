module ShopifyAPI
  class Customer < Base
    include Metafields

    def self.search(params)
      self.find(:all, from: '/admin/customers/search.json',params: params)
    end
  end
end
