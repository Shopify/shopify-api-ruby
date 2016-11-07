module ShopifyAPI
  module OnlySyncDirtyAttributes
    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if match_data = /(?<attribute_name>.+)(?:=)$/.match(method_name)
        changed << match_data[:attribute_name]
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
