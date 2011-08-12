module ShopifyAPI
  class Blog < Base
    def articles
      Article.find(:all, :params => { :blog_id => id })
    end
  end
end
