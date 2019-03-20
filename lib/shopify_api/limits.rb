module ShopifyAPI
  module Limits
    class LimitUnavailable < StandardError; end

    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

    module ClassMethods
      # Takes form <call count>/<bucket size>
      # See https://help.shopify.com/en/api/getting-started/api-call-limit
      # Eg: 2/40
      CALL_LIMIT_HEADER = 'X-Shopify-Shop-Api-Call-Limit'

      ##
      # How many more API calls can I make?
      # @return {Integer}
      #
      def available_calls
        call_limit - call_count
      end

      ##
      # Have I reached my API call limit?
      # @return {Boolean}
      #
      def maxed?
        available_calls <= 0
      end

      ##
      # How many total API calls can I make?
      # @return {Integer}
      #
      def call_limit
        call_limit_status[1].to_i - 1
      end

      ##
      # How many API calls have I made?
      # @return {Integer}
      #
      def call_count
        call_limit_status[0].to_i
      end

      ##
      # @return {HTTPResonse}
      #
      def response
        Shop.current unless ShopifyAPI::Base.connection.response
        ShopifyAPI::Base.connection.response
      end

      private

      ##
      # @return {Array}
      #
      def call_limit_status
        header = response[CALL_LIMIT_HEADER]
        raise LimitUnavailable unless header
        header.split('/')
      end
    end
  end
end
