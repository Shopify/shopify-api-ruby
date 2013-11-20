module ShopifyAPI
  class Article < Base
    include Events
    include Metafields
    include DisablePrefixCheck

    self.prefix = "/admin/blogs/:blog_id/"
     
    def self.prefix(options={})
      options[:blog_id].nil? ? "/admin/" : "/admin/blogs/#{options[:blog_id]}/"
    end

    def comments
      Comment.find(:all, :params => { :article_id => id })
    end

    def self.authors(options = {})
      get(:authors, options)
    end

    def self.tags(options={})
      get(:tags, options)
    end
  end
end
