module ShopifyAPI
  module OnlySyncDirtyAttributes
    def method_missing(method_symbol, *args)
      method_name = method_symbol.to_s

      if match_data = /(?<attribute_name>.+)(?:=)$/.match(method_name)
        changed << match_data[:attribute_name]
      end

      super
    end

    def save(*)
      with_dirty_attributes { super }
    end

    private

    def with_dirty_attributes
      old_attributes = @attributes.dup
      slice_attributes_on_changed
      yield
      clear_changed_attributes
    rescue ActiveResource::ClientError,
      ActiveResource::ConnectionError,
      ActiveResource::TimeoutError => e
      @attributes = old_attributes
      raise(e)
    end

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
