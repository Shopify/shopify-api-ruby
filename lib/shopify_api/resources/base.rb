require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    def encode(options = {})
      same = dup
      same.attributes = {self.class.element_name => same.attributes} if self.class.format.extension == 'json'

      same.send("to_#{self.class.format.extension}", options)
    end
    
    def as_json(options = nil)
      root = options[:root] if options.try(:key?, :root)
      if include_root_in_json
        root = self.class.model_name.element if root == true
        { root => serializable_hash(options) }
      else
        serializable_hash(options)
      end
    end

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

    private
    def only_id
      encode(:only => :id, :include => [], :methods => [])
    end
  end
end
