require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')



    def self.activate_session(session)
      self.site = session.site
      ActiveResource::Base.site = session.site
      self.headers.merge!('X-Shopify-Access-Token' => session.token)
      ActiveResource::Base.headers.merge!('X-Shopify-Access-Token' => session.token)
    end

    def self.clear_session
      self.site = nil
      ActiveResource::Base.site = nil
      self.headers.delete('X-Shopify-Access-Token')
      ActiveResource::Base.headers.delete('X-Shopify-Access-Token')
    end                                  

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
