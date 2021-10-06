# frozen_string_literal: true
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
      _escape(key.to_s, _make_regex('&=%'))
    end

    def self.encode_value(value)
      _escape(value.to_s, _make_regex('&%'))
    end
  end
end
