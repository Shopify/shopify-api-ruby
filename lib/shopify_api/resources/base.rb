require 'shopify_api/version'

module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = true
    self.headers['User-Agent'] = ["ShopifyAPI/#{ShopifyAPI::VERSION}",
                                  "ActiveResource/#{ActiveResource::VERSION::STRING}",
                                  "Ruby/#{RUBY_VERSION}"].join(' ')

    # this patch only needed until 3.1 because ActiveResouce 3.2 passes :root to as_json (and encode regardless of include_root_in_json)
    if ActiveResource::VERSION::MAJOR == 3 && ActiveResource::VERSION::MINOR <= 1
      self.include_root_in_json = false

      def encode(options = {})
        same = dup
        same.attributes = {self.class.element_name => same.attributes} if self.class.format.extension == 'json'

        same.send("to_#{self.class.format.extension}", options)
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
