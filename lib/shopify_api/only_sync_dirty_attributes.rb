module ShopifyAPI
  module OnlySyncDirtyAttributes
    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if method_name =~ /(=)$/
        changed << $`
      end

      super
    end

    def save
      slice_attributes_on_changed
      base = super
      clear_changed_attributes
      base
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
