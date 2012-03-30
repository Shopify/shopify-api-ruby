
module ShopifyAPI
  
  class Session
    cattr_accessor :api_key
    cattr_accessor :secret
    cattr_accessor :protocol 
    self.protocol = 'https'

    attr_accessor :url, :token, :name
    
    class << self
    
      def setup(params)
        params.each { |k,value| send("#{k}=", value) }
      end
      
      def temp(domain, token, &block)
        session = new(domain, token)

        original_domain  = URI.parse(ShopifyAPI::Base.site).host
        original_token   = ShopifyAPI::Base.headers['X-Shopify-Access-Token']
        original_session = new(original_domain, original_token)

        begin
          activate_session(session)
          yield
        ensure
          activate_session(original_session)
        end
      end
      
      def prepare_url(url)
        return nil if url.blank?
        url.gsub!(/https?:\/\//, '')                            # remove http:// or https://
        url.concat(".myshopify.com") unless url.include?('.')   # extend url to myshopify.com if no host is given
      end
    end
    
    def initialize(url, token = nil, params = nil)
      self.url, self.token = url, token
      self.class.prepare_url(self.url)
    end
    
    def shop
      Shop.current
    end

    def site
      "#{protocol}://#{url}/admin"
    end

    def valid?
      url.present? && token.present?
    end
  
  end
end
