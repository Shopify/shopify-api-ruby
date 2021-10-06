require 'webrick/httputils'

module ShopifyAPI
  module HmacParams
    extend WEBrick::HTTPUtils

    def self.encode(params)
      params
        .except(:signature, :hmac, :action, :controller)
        .map { |k,v| sprintf("%s=%s", encode_key(k), encode_value(v)) }
        .sort.join("&")
    end

    def self.encode_key(key)
      URI.escape(key.to_s, '&=%')
    end

    def self.encode_value(value)
      URI.escape(value.to_s, '&%')
    end
  end
end
