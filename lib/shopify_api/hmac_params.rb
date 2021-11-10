# frozen_string_literal: true

module ShopifyAPI
  module HmacParams
    class << self
      def encode(params)
        params
          .except(:signature, :hmac, :action, :controller)
          .map { |k,v| sprintf("%s=%s", encode_key(k), encode_value(v)) }
          .sort.join("&")
      end

      KEY_REGEXP = /([#{Regexp.escape("&=%")}])/n
      def encode_key(key)
        _escape(key.to_s, KEY_REGEXP)
      end

      VALUE_REGEXP = /([#{Regexp.escape("&%")}])/n
      def encode_value(value)
        _escape(value.to_s, VALUE_REGEXP)
      end

      private

      def _escape(str, regex)
        str = str.b
        str.gsub!(regex) {"%%%02X" % $1.ord}
        # %-escaped string should contain US-ASCII only
        str.force_encoding(Encoding::US_ASCII)
      end
    end
  end
end
