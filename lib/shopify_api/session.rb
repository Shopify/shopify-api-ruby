require 'openssl'
require 'rack'

module ShopifyAPI

  class ValidationException < StandardError
  end

  class Session
    cattr_accessor :api_key, :secret, :protocol, :myshopify_domain, :port
    self.protocol = 'https'
    self.myshopify_domain = 'myshopify.com'

    attr_accessor :url, :token, :name, :extra

    class << self

      def setup(params)
        params.each { |k,value| public_send("#{k}=", value) }
      end

      def temp(domain, token, extra = nil, &block)
        session = new(domain, token, extra)
        original_site = ShopifyAPI::Base.site.to_s
        original_token = ShopifyAPI::Base.headers['X-Shopify-Access-Token']
        original_session = new(original_site, original_token, extra)

        begin
          ShopifyAPI::Base.activate_session(session)
          yield
        ensure
          ShopifyAPI::Base.activate_session(original_session)
        end
      end

      def prepare_url(url)
        return nil if url.blank?
        # remove http:// or https://
        url = url.strip.gsub(/\Ahttps?:\/\//, '')
        # extract host, removing any username, password or path
        shop = URI.parse("https://#{url}").host
        # extract subdomain of .myshopify.com
        if idx = shop.index(".")
          shop = shop.slice(0, idx)
        end
        return nil if shop.empty?
        shop = "#{shop}.#{myshopify_domain}"
        port ? "#{shop}:#{port}" : shop
      rescue URI::InvalidURIError
        nil
      end

      def validate_signature(params)
        params = params.with_indifferent_access
        return false unless signature = params[:hmac]

        calculated_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new(), secret, encoded_params_for_signature(params))

        Rack::Utils.secure_compare(calculated_signature, signature)
      end

      private

      def encoded_params_for_signature(params)
        params = params.except(:signature, :hmac, :action, :controller)
        params.map{|k,v| "#{URI.escape(k.to_s, '&=%')}=#{URI.escape(v.to_s, '&%')}"}.sort.join('&')
      end
    end

    def initialize(url, token = nil, extra = nil)
      self.url = self.class.prepare_url(url)
      self.token = token
      self.extra = extra || {}
    end

    def create_permission_url(scope, redirect_uri = nil)
      params = {:client_id => api_key, :scope => scope.join(',')}
      params[:redirect_uri] = redirect_uri if redirect_uri
      "#{site}/oauth/authorize?#{parameterize(params)}"
    end

    def request_token(params)
      return token if token

      unless self.class.validate_signature(params) && params[:timestamp].to_i > 24.hours.ago.utc.to_i
        raise ShopifyAPI::ValidationException, "Invalid Signature: Possible malicious login"
      end

      response = access_token_request(params['code'])
      if response.code == "200"
        self.extra = JSON.parse(response.body)
        self.token = extra.delete('access_token')

        if expires_in = extra.delete('expires_in')
          extra['expires_at'] = Time.now.utc.to_i + expires_in
        end
        token
      else
        raise RuntimeError, response.msg
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

    def expires_in
      return unless expires_at.present?
      [0, expires_at.to_i - Time.now.utc.to_i].max
    end

    def expires_at
      return unless extra.present?
      @expires_at ||= Time.at(extra['expires_at']).utc
    end

    def expired?
      return false if expires_in.nil?
      expires_in <= 0
    end

    private
      def parameterize(params)
        URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
      end

      def access_token_request(code)
        uri = URI.parse("#{protocol}://#{url}/admin/oauth/access_token")
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({"client_id" => api_key, "client_secret" => secret, "code" => code})
        https.request(request)
      end
  end
end
