module ShopifyAPI
  class Session
    class << self
      def temp(domain, token, &block)
        store_current_session
        ShopifyAPI::Base.activate_session new(domain, token)
        yield if block_given?
      ensure
        restore_previous_session
      end

      private

      def current_domain
        host_with_port(ShopifyAPI::Base.site.to_s)
      rescue URI::InvalidURIError
        nil
      end

      def current_token
        ShopifyAPI::Base.headers['X-Shopify-Access-Token']
      end

      def store_current_session
        @saved_session = new(current_domain, current_token)
      end

      def restore_previous_session
        ShopifyAPI::Base.activate_session(@saved_session)
        @saved_session = nil
      end
    end
  end
end
