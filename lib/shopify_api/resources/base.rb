require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false

    def self.inherited(klass)
      super
      klass.headers['User-Agent'] = Base.headers['User-Agent']
    end
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
