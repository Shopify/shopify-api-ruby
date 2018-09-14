# frozen_string_literal: true

module ShopifyAPI
  class Payment < Base
    self.prefix = '/admin/checkouts/:checkout_id/'
  end
end
