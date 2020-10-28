# frozen_string_literal: true
module ShopifyAPI
  class LineItem < Base
    class Property < Base
      def initialize(*args)
        self.attributes = args[0] || {}
        self.persisted = args[1] || false
        super
      rescue NameError
        self.attributes = attributes.to_hash
        self
      end
    end
  end
end
