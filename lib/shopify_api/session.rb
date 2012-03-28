
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

        original_site = ShopifyAPI::Base.site
        begin
          ShopifyAPI::Base.site = session.site
          yield
        ensure
          ShopifyAPI::Base.site = original_site
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
      "#{protocol}://:#{token}@#{url}/admin"
    end

    def valid?
      url.present? && token.present?
    end
  
  end
end
