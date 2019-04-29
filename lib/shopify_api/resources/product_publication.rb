# frozen_string_literal: true
module ShopifyAPI
  class ProductPublication < Base
    init_prefix :publication

    def publication_id
      @prefix_options[:publication_id]
    end
  end
end
