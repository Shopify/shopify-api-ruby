# frozen_string_literal: true
module ShopifyAPI
  class AccessScope < Base
    class << self
      def prefix(_options = {})
        '/admin/oauth/'
      end
    end
  end
end
