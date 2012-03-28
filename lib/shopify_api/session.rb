module ShopifyAPI
  # 
  #  The Shopify API authenticates each call via HTTP Authentication, using
  #    * the application's API key as the username, and
  #    * a hex digest of the application's shared secret and an 
  #      authentication token as the password.
  #  
  #  Generation & acquisition of the beforementioned looks like this:
  # 
  #    0. Developer (that's you) registers Application (and provides a
  #       callback url) and receives an API key and a shared secret
  # 
  #    1. User visits Application and are told they need to authenticate the
  #       application first for read/write permission to their data (needs to
  #       happen only once). User is asked for their shop url.
  # 
  #    2. Application redirects to Shopify : GET <user's shop url>/admin/api/auth?api_key=<API key>
  #       (See Session#create_permission_url)
  # 
  #    3. User logs-in to Shopify, approves application permission request
  # 
  #    4. Shopify redirects to the Application's callback url (provided during
  #       registration), including the shop's name, and an authentication token in the parameters:
  #         GET client.com/customers?shop=snake-oil.myshopify.com&t=a94a110d86d2452eb3e2af4cfb8a3828
  # 
  #    5. Authentication password computed using the shared secret and the
  #       authentication token (see Session#computed_password)
  # 
  #    6. Profit!
  #       (API calls can now authenticate through HTTP using the API key, and
  #       computed password)
  # 
  #  LoginController and ShopifyLoginProtection use the Session class to set Shopify::Base.site
  #  so that all API calls are authorized transparently and end up just looking like this:
  # 
  #    # get 3 products
  #    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 3})
  #    
  #    # get latest 3 orders
  #    @orders = ShopifyAPI::Order.find(:all, :params => {:limit => 3, :order => "created_at DESC" })
  # 
  #  As an example of what your LoginController should look like, take a look
  #  at the following:
  # 
  #    class LoginController < ApplicationController
  #      def index
  #        # Ask user for their #{shop}.myshopify.com address
  #      end
  #    
  #      def authenticate
  #        redirect_to ShopifyAPI::Session.new(params[:shop]).create_permission_url
  #      end
  #    
  #      # Shopify redirects the logged-in user back to this action along with
  #      # the authorization token t.
  #      # 
  #      # This token is later combined with the developer's shared secret to form
  #      # the password used to call API methods.
  #      def finalize
  #        shopify_session = ShopifyAPI::Session.new(params[:shop], params[:t])
  #        if shopify_session.valid?
  #          session[:shopify] = shopify_session
  #          flash[:notice] = "Logged in to shopify store."
  #    
  #          return_address = session[:return_to] || '/home'
  #          session[:return_to] = nil
  #          redirect_to return_address
  #        else
  #          flash[:error] = "Could not log in to Shopify store."
  #          redirect_to :action => 'index'
  #        end
  #      end
  #    
  #      def logout
  #        session[:shopify] = nil
  #        flash[:notice] = "Successfully logged out."
  #    
  #        redirect_to :action => 'index'
  #      end
  #    end
  # 
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
      
      def validate_signature(params)
        return false unless signature = params[:signature]

        sorted_params = params.except(:signature, :action, :controller).collect{|k,v|"#{k}=#{v}"}.sort.join
        Digest::MD5.hexdigest(secret + sorted_params) == signature
      end
    
    end
    
    def initialize(url, token = nil, params = nil)
      self.url, self.token = url, token
      self.class.prepare_url(self.url)
    end
    
    def shop
      Shop.current
    end
    
    def create_permission_url
      return nil if url.blank? || api_key.blank?
      "http://#{url}/admin/api/auth?api_key=#{api_key}"
    end

    # Used by ActiveResource::Base to make all non-authentication API calls
    # 
    # (ShopifyAPI::Base.site set in ShopifyLoginProtection#shopify_session)
    def site
      "#{protocol}://#{api_key}:#{computed_password}@#{url}/admin"
    end

    def valid?
      url.present? && token.present?
    end

    private

    # The secret is computed by taking the shared_secret which we got when 
    # registring this third party application and concating the request_to it, 
    # and then calculating a MD5 hexdigest. 
    def computed_password
      token.to_s
    end
    
  end
end
