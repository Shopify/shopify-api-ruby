module ShopifyAPI
  METAFIELD_ENABLED_CLASSES = %w( Order Product CustomCollection SmartCollection Page Blog Article Variant)
  
  # Include Metafields module in all enabled classes
  METAFIELD_ENABLED_CLASSES.each do |klass|
    "ShopifyAPI::#{klass}".constantize.send(:include, Metafields)
  end
end
