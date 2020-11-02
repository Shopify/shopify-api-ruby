# frozen_string_literal: true
module ShopifyAPI
  class Blog < Base
    include Events
    include Metafields

    def articles
      Article.find(:all, params: { blog_id: id })
    end
  end
end
