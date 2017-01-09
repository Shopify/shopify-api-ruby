module ShopifyAPI
  module DirtyAttributesEncoder
    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if match_data = /(?<attribute_name>.+)(?:=)$/.match(method_name)
        changed_attributes << match_data[:attribute_name]
      end

      super
    end

    def encode(options = {})
      super(options.merge(only: changed_attributes_including_pk))
      clear_changed_attributes
    end

    private

    def changed_attributes_including_pk
      [changed_attributes, self.class.primary_key].flatten
    end

    def clear_changed_attributes
      changed_attributes.clear
    end

    def changed_attributes
      @changed_attributes ||= []
    end
  end
end
