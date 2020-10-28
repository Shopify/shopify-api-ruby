# frozen_string_literal: true
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
      CREDIT_LIMIT_HEADER_PARAM = {
        shop: 'X-Shopify-Shop-Api-Call-Limit',
      }

      ##
      # How many more API calls can I make?
      # @return {Integer}
      #
      def credit_left
        credit_limit(:shop) - credit_used(:shop)
      end
      alias_method :available_calls, :credit_left

      ##
      # Have I reached my API call limit?
      # @return {Boolean}
      #
      def credit_maxed?
        credit_left <= 0
      end
      alias_method :maxed?, :credit_maxed?

      ##
      # How many total API calls can I make?
      # NOTE: subtracting 1 from credit_limit because I think ShopifyAPI cuts off at 299 or shop limits.
      # @param {Symbol} scope [:shop]
      # @return {Integer}
      #
      def credit_limit(scope = :shop)
        api_credit_limit_param(scope).pop.to_i - 1
      end
      alias_method :call_limit, :credit_limit

      ##
      # How many API calls have I made?
      # @param {Symbol} scope [:shop]
      # @return {Integer}
      #
      def credit_used(scope = :shop)
        api_credit_limit_param(scope).shift.to_i
      end
      alias_method :call_count, :credit_used

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
      def api_credit_limit_param(scope)
        header = response[CREDIT_LIMIT_HEADER_PARAM[scope]]
        raise LimitUnavailable unless header
        header.split('/')
      end
    end
  end
end
