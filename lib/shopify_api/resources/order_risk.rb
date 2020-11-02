# frozen_string_literal: true
module ShopifyAPI
  class OrderRisk < Base
    init_prefix :order

    self.collection_name = "risks"
    self.element_name = "risk"
  end
end
