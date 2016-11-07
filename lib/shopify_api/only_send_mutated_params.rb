module ShopifyAPI
  module OnlySendMutatedParams
    def self.included(base)
      base.class_eval do
        before_save :slice_attributes_on_changed
        after_save :clear_changed_attributes
      end
    end

    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if method_name =~ /(=)$/
        changed << $`
      end

      super
    end

    private

    def slice_attributes_on_changed
      @attributes.slice!(*[changed, self.class.primary_key].flatten)
    end

    def clear_changed_attributes
      changed.clear
    end

    def changed
      @changed ||= []
    end
  end
end
