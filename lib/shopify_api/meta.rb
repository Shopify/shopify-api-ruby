
# frozen_string_literal: true
module ShopifyAPI
  class Meta < ActiveResource::Base
    self.site = "https://app.shopify.com/services/"
    self.element_name = 'api'
    self.primary_key = :handle

    has_many :versions, class_name: "ShopifyAPI::ApiVersion"

    def self.admin_versions
      all.find { |api| api.handle = :admin }.versions
    end
  end
end

