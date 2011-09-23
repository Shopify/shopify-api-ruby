# based on code from https://github.com/christocracy/shopify-api-limits
module ShopifyAPI
  module Limits
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end
    
    module ClassMethods

      # Takes form num_requests_executed/max_requests
      # Eg: 101/3000
      CREDIT_LIMIT_HEADER_PARAM = {
        :global => 'http_x_shopify_api_call_limit',
        :shop => 'http_x_shopify_shop_api_call_limit'
      }

        ##
      # How many more API calls can I make?
      # @return {Integer}
      #
      def credit_left
        shop = credit_limit(:shop) - credit_used(:shop)
        global = credit_limit(:global) - credit_used(:global)      
        shop < global ? shop : global
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
      # NOTE: subtracting 1 from credit_limit because I think ShopifyAPI cuts off at 299/2999 or shop/global limits.
      # @param {Symbol} scope [:shop|:global]
      # @return {Integer}
      #
      def credit_limit(scope=:shop)
        @api_credit_limit ||= {}
        @api_credit_limit[scope] ||= api_credit_limit_param(scope).pop.to_i - 1     
      end
      alias_method :call_limit, :credit_limit

      ##
      # How many API calls have I made?
      # @param {Symbol} scope [:shop|:global]
      # @return {Integer}
      #
      def credit_used(scope=:shop)
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
        response[CREDIT_LIMIT_HEADER_PARAM[scope]].split('/')
      end    
    end
  end
end
