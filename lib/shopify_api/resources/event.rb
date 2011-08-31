module ShopifyAPI
  class Event < Base
    self.prefix = "/admin/:resource/:resource_id/"
    
    # Hack to allow both Shop and other Events in through the same AR class
    def self.prefix(options={})
      options[:resource].nil? ? "/admin/" : "/admin/#{options[:resource]}/#{options[:resource_id]}/"
    end
  end
end
