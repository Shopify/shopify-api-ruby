module ShopifyAPI
  class Article < Base
    include Events
    include Metafields

    self.prefix = "/admin/blogs/:blog_id/"
    
    def comments
      Comment.find(:all, :params => { :article_id => id })
    end
  end
end
