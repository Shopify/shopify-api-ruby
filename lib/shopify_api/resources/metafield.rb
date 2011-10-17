module ShopifyAPI
  class Metafield < Base
    self.prefix = "/admin/"
    
    # Hack to allow both Shop and other Metafields in through the same AR class
    def self.prefix(options={})
      options[:resource].nil? ? "/admin/" : "/admin/#{options[:resource]}/#{options[:resource_id]}/"
    end
            
    def value
      return if attributes["value"].nil?
      attributes["value_type"] == "integer" ? attributes["value"].to_i : attributes["value"]
    end
  end
end
