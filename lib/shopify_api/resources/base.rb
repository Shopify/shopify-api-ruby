require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    class << self
      def headers
        if defined?(@headers)
          @headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          @headers ||= {}
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

    def encode(options = {})
      obj = dup

      if self.class.format.extension == 'json' && !already_has_root_element?(obj.attributes)
        obj.attributes = {self.class.element_name => obj.attributes}
      end

      obj.send("to_#{self.class.format.extension}", options)
    end
    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end

    def already_has_root_element?(attributes)
      attributes.keys.size == 1 && attributes.values.first.kind_of?(Hash)
    end
  end
end
 
