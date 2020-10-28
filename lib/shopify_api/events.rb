# frozen_string_literal: true
module ShopifyAPI
  module Events
    def events
      Event.find(:all, params: { resource: self.class.collection_name, resource_id: id })
    end
  end
end
