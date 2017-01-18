module ShopifyAPI
  module DirtyAttributesEncoder
    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if match_data = /(?<attribute_name>.+)(?:=)$/.match(method_name)
        changed_attributes << match_data[:attribute_name]
      end

      super
    end

    def encode(*)
      with_dirty_attributes do
        super
        clear_changed_attributes
      end
    end

    private

    def with_dirty_attributes
      @old_attributes = @attributes.dup
      @attributes = @attributes.slice(changed_attributes_including_pk)
      yield
    ensure
      @attributes = @old_attributes
    end

    def changed_attributes_including_pk
      [changed_attributes, self.class.primary_key].flatten.map(&:to_sym)
    end

    def clear_changed_attributes
      changed_attributes.clear
    end

    def changed_attributes
      @changed_attributes ||= []
    end
  end
end
