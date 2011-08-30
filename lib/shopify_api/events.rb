module ShopifyAPI
  EVENT_ENABLED_CLASSES = %w( Order Product CustomCollection SmartCollection Page Blog Article )
  
  # Include Events module in all enabled classes
  EVENT_ENABLED_CLASSES.each do |klass|
    "ShopifyAPI::#{klass}".constantize.send(:include, Events)
  end
end
