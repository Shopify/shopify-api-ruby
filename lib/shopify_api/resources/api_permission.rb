# frozen_string_literal: true

module ShopifyAPI
  class ApiPermission < Base
    def self.destroy
      delete(:current)
    end
  end
end
