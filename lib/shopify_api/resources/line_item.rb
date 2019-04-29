module ShopifyAPI
  class LineItem < Base
    class Property < Base
      def initialize(*args)
        attributes = args[0] || {}
        persisted = args[1] || false
        super
      rescue NameError
        attributes = attributes.to_hash
        self
      end
    end
  end
end
