module ShopifyAPI
  class Policy < Base
    def self.all
      find(:all)
    end
  end
end
