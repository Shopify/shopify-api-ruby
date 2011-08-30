module ShopifyAPI
  class Event < Base
    self.prefix = "/admin/:resource/:resource_id/"
    
    # Hack to allow both Shop and other Events in through the same AR class
    def self.prefix(options={})
      options[:resource].nil? ? "/admin/" : "/admin/#{options[:resource]}/#{options[:resource_id]}/"
    end
  end
  
  module Events
    def events
      Event.find(:all, :params => {:resource => self.class.collection_name, :resource_id => id})
    end
  end
end
