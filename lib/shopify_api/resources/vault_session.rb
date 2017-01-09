module ShopifyAPI
  # avoid removing root_key as it activeresource object initialization
  # https://github.com/rails/activeresource/blob/master/lib/active_resource/formats/json_format.rb#L21
  module VaultSessionFormat
    extend self

    def extension
      "json"
    end

    def mime_type
      "application/json"
    end

    def encode(hash, options = nil)
      ActiveSupport::JSON.encode(hash, options)
    end

    def decode(json)
      ActiveSupport::JSON.decode(json)
    end
  end

  class VaultSession < Base
    self.element_name = "session"
    self.format = VaultSessionFormat
    self.site = "https://elb.deposit.shopifycs.com"
  end
end
