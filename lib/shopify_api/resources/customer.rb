module ShopifyAPI
  class Customer < Base
    include Metafields

    def self.search(query_string)
      self.find(:all, from: '/admin/customers/search.json',params: {query: query_string})
    end
  end
end
