module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
