# frozen_string_literal: true

module ShopifyAPI
  class Payment < Base
    self.resource_prefix = "checkouts/:checkout_id/"
  end
end
