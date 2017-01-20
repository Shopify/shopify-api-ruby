module ShopifyAPI
  class VaultSession < Base
    self.element_name = "session"
    self.format = VaultSessionFormat
    self.site = "https://elb.deposit.shopifycs.com"
  end
end
