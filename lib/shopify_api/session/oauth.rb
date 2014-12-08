module ShopifyAPI
  class ValidationException < StandardError; end

  class Session
    cattr_accessor :api_key
    cattr_accessor :secret

    attr_accessor :token

    class << self
      def validate_signature(params)
        params = params.with_indifferent_access
        return false unless signature = params[:signature]
        params[:timestamp].to_i > 24.hours.ago.utc.to_i &&
        Digest::MD5.hexdigest(secret + sort_params(params)) == signature
      end

      private

      def sort_params(params)
        params.except(*ignored_params).collect {|key, value|
          "#{key}=#{value}"
        }.sort.join
      end

      def ignored_params
        [:signature, :action, :controller]
      end
    end

    def create_permission_url(scope, redirect_uri=nil)
      uri.build(
        host: url,
        path: "/admin/oauth/authorize",
        query: oauth_authorize_params(scope, redirect_uri).to_query
      ).to_s
    end

    def request_token(params)
      return token if token.present?
      raise_validation_exception unless self.class.validate_signature(params)
      response = access_token_request(params['code'])
      raise RuntimeError, response.msg unless response.code == "200"
      JSON.parse(response.body)['access_token']
    end

    private

    def raise_validation_exception
      raise ValidationException,
        "Invalid Signature: Possible malicious login",
        caller
    end

    def oauth_authorize_params(scope, redirect_uri)
      {}.tap do |params|
        params[:client_id] = api_key
        params[:scope] = scope.join(",")
        params[:redirect_uri] = redirect_uri if redirect_uri.present?
      end
    end

    def access_token_request(code)
      u = uri.build(host: url, path: "/admin/oauth/access_token")
      https = Net::HTTP.new(u.host, u.port).tap {|h| h.use_ssl = true }
      request = Net::HTTP::Post.new(u.request_uri)
      request.set_form_data(access_token_request_params(code))
      https.request(request)
    end

    def access_token_request_params(code)
      { "client_id" => api_key,
        "client_secret" => secret,
        "code" => code }
    end
  end
end
