# frozen_string_literal: true
require 'openssl'
require 'rack'

module ShopifyAPI
  class ValidationException < StandardError
  end

  class Session
    SECONDS_IN_A_DAY = 24 * 60 * 60

    cattr_accessor :api_key, :secret, :myshopify_domain
    self.myshopify_domain = 'myshopify.com'

    attr_accessor :domain, :token, :name, :extra
    attr_reader :api_version, :access_scopes
    alias_method :url, :domain

    class << self
      def setup(params)
        params.each { |k, value| public_send("#{k}=", value) }
      end

      def temp(domain:, token:, api_version: ShopifyAPI::Base.api_version, &block)
        session = new(domain: domain, token: token, api_version: api_version)

        with_session(session, &block)
      end

      def with_session(session, &_block)
        original_session = extract_current_session
        original_user = ShopifyAPI::Base.user
        original_password = ShopifyAPI::Base.password

        begin
          ShopifyAPI::Base.clear_session
          ShopifyAPI::Base.activate_session(session)
          yield
        ensure
          ShopifyAPI::Base.activate_session(original_session)
          ShopifyAPI::Base.user = original_user
          ShopifyAPI::Base.password = original_password
        end
      end

      def with_version(api_version, &block)
        original_session = extract_current_session
        session = new(domain: original_session.site, token: original_session.token, api_version: api_version)

        with_session(session, &block)
      end

      def prepare_domain(domain)
        return nil if domain.blank?
        # remove http:// or https://
        domain = domain.strip.gsub(%r{\Ahttps?://}, '')
        # extract host, removing any username, password or path
        shop = URI.parse("https://#{domain}").host
        # extract subdomain of .myshopify.com
        if (idx = shop.index("."))
          shop = shop.slice(0, idx)
        end
        return nil if shop.empty?
        "#{shop}.#{myshopify_domain}"
      rescue URI::InvalidURIError
        nil
      end

      def validate_signature(params)
        params = (params.respond_to?(:to_unsafe_hash) ? params.to_unsafe_hash : params).with_indifferent_access
        return false unless (signature = params[:hmac])

        calculated_signature = OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new('SHA256'), secret, ShopifyAPI::HmacParams.encode(params)
        )

        Rack::Utils.secure_compare(calculated_signature, signature)
      end

      private

      def extract_current_session
        site = ShopifyAPI::Base.site.to_s
        token = ShopifyAPI::Base.headers['X-Shopify-Access-Token']
        version = ShopifyAPI::Base.api_version
        new(domain: site, token: token, api_version: version)
      end
    end

    def initialize(domain:, token:, access_scopes: nil, api_version: ShopifyAPI::Base.api_version, extra: {})
      self.domain = self.class.prepare_domain(domain)
      self.api_version = api_version
      self.token = token
      self.access_scopes = access_scopes
      self.extra = extra
    end

    def create_permission_url(scope, redirect_uri, options = {})
      params = { client_id: api_key, scope: ShopifyAPI::ApiAccess.new(scope).to_s, redirect_uri: redirect_uri }
      params[:state] = options[:state] if options[:state]
      params["grant_options[]".to_sym] = options[:grant_options] if options[:grant_options]
      construct_oauth_url("authorize", params)
    end

    def request_token(params)
      return token if token

      twenty_four_hours_ago = Time.now.utc.to_i - SECONDS_IN_A_DAY
      unless self.class.validate_signature(params) && params[:timestamp].to_i > twenty_four_hours_ago
        raise ShopifyAPI::ValidationException, "Invalid Signature: Possible malicious login"
      end

      response = access_token_request(params[:code])
      if response.code == "200"
        self.extra = JSON.parse(response.body)
        self.token = extra.delete('access_token')

        if (expires_in = extra.delete('expires_in'))
          extra['expires_at'] = Time.now.utc.to_i + expires_in
        end
        token
      else
        raise response.msg
      end
    end

    def shop
      Shop.current
    end

    def site
      "https://#{domain}"
    end

    def api_version=(version)
      @api_version = if ApiVersion::NullVersion.matches?(version)
        ApiVersion::NullVersion
      else
        ApiVersion.find_version(version)
      end
    end

    def valid?
      domain.present? && token.present? && api_version.is_a?(ApiVersion)
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

    def hash
      state.hash
    end

    def ==(other)
      self.class == other.class && state == other.state
    end

    alias_method :eql?, :==

    protected

    def state
      [domain, token, api_version, extra]
    end

    private

    def access_scopes=(access_scopes)
      return unless access_scopes
      @access_scopes = ShopifyAPI::ApiAccess.new(access_scopes)
    end

    def parameterize(params)
      URI.encode_www_form(params)
    end

    def access_token_request(code)
      uri = URI.parse(construct_oauth_url('access_token'))
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data('client_id' => api_key, 'client_secret' => secret, 'code' => code)
      https.request(request)
    end

    def construct_oauth_url(path, query_params = {})
      query_string = "?#{parameterize(query_params)}" unless query_params.empty?
      "https://#{domain}/admin/oauth/#{path}#{query_string}"
    end
  end
end
