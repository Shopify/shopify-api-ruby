require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable

    USER_AGENT = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                  "Ruby/#{RUBY_VERSION}"].join(' ')

    self.include_root_in_json = true

    class << self
      def headers
        if superclass != ActiveResource::Base
          superclass.headers
        else
          super.merge!('User-Agent' => USER_AGENT)
        end
      end

      def activate_session(session)
        self.site = session.site
        self.headers.merge!('X-Shopify-Access-Token' => session.token)
      end

      def clear_session
        self.site = nil
        self.headers.delete('X-Shopify-Access-Token')
      end
    end

    def persisted?
      !id.nil?
    end

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
