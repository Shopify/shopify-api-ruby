
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
        begin
          original_domain = host_with_port(ShopifyAPI::Base.site.to_s)
        rescue URI::InvalidURIError
        end
        original_token   = ShopifyAPI::Base.headers['X-Shopify-Access-Token']
        original_session = new(original_domain, original_token)

        begin
          ShopifyAPI::Base.activate_session(session)
          yield
        ensure
          ShopifyAPI::Base.activate_session(original_session)
        end
      end
      
      def prepare_url(url)
        return nil if url.blank?
        url.gsub!(/https?:\/\//, '')                            # remove http:// or https://
        url.concat(".myshopify.com") unless url.include?('.')   # extend url to myshopify.com if no host is given
      end

      def validate_signature(params)
        return false unless signature = params[:signature]

        sorted_params = params.except(:signature, :action, :controller).collect{|k,v|"#{k}=#{v}"}.sort.join
        Digest::MD5.hexdigest(secret + sorted_params) == signature
      end

      def host_with_port(site)
        parsed_site = URI.parse(site)
        host = parsed_site.host or return
        port = parsed_site.port
        if (protocol == 'http' && port == 80) || (protocol == 'https' && port == 443)
          host
        else
          "#{host}:#{port}"
        end
      end

    end
    
    def initialize(url, token = nil, params = nil)
      self.url, self.token = url, token
      self.class.prepare_url(self.url)

      if params
        unless self.class.validate_signature(params) && params[:timestamp].to_i > 24.hours.ago.utc.to_i
          raise "Invalid Signature: Possible malicious login" 
        end
      end
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
