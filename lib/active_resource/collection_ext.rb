require 'shopify_api/collection_pagination'

module ActiveResource
  class Collection
    prepend ShopifyAPI::CollectionPagination
  end
end
