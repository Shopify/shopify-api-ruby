# frozen_string_literal: true
module ShopifyAPI
  class Article < Base
    include Events
    include Metafields
    include DisablePrefixCheck

    conditional_prefix :blog

    def comments
      Comment.find(:all, params: { article_id: id })
    end

    def self.authors(options = {})
      get(:authors, options)
    end

    def self.tags(options = {})
      get(:tags, options)
    end
  end
end
