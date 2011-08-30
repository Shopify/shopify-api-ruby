module ShopifyAPI
  module Metafields
    def metafields
      Metafield.find(:all, :params => {:resource => self.class.collection_name, :resource_id => id})
    end
    
    def add_metafield(metafield)
      raise ArgumentError, "You can only add metafields to resource that has been saved" if new?
      
      metafield.prefix_options = {
        :resource => self.class.collection_name,
        :resource_id => id
      }
      metafield.save
      metafield
    end
  end
  
  class Metafield < Base
    self.prefix = "/admin/:resource/:resource_id/"
    
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
