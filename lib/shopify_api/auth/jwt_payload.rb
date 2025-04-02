# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class JwtPayload
      extend T::Sig

      JWT_LEEWAY = 10
      JWT_EXPIRATION_LEEWAY = JWT_LEEWAY

      sig { returns(String) }
      attr_reader :iss, :dest, :aud, :jti

      sig { returns(Integer) }
      attr_reader :exp, :nbf, :iat

      sig { returns(T.nilable(String)) }
      attr_reader :sub, :sid

      alias_method :expire_at, :exp

      sig { params(token: String).void }
      def initialize(token)
        payload_hash = begin
          decode_token(token, Context.api_secret_key)
        rescue ShopifyAPI::Errors::InvalidJwtTokenError
          raise unless Context.old_api_secret_key

          decode_token(token, T.must(Context.old_api_secret_key))
        end

        @iss = T.let(payload_hash["iss"], String)
        @dest = T.let(payload_hash["dest"], String)
        @aud = T.let(payload_hash["aud"], String)
        @sub = T.let(payload_hash["sub"], T.nilable(String))
        @exp = T.let(payload_hash["exp"], Integer)
        @nbf = T.let(payload_hash["nbf"], Integer)
        @iat = T.let(payload_hash["iat"], Integer)
        @jti = T.let(payload_hash["jti"], String)
        @sid = T.let(payload_hash["sid"], T.nilable(String))

        raise ShopifyAPI::Errors::InvalidJwtTokenError,
          "Session token had invalid API key" unless @aud == Context.api_key
      end

      sig { returns(String) }
      def shop
        @dest.gsub("https://", "")
      end
      alias_method :shopify_domain, :shop

      sig { returns(T.nilable(Integer)) }
      def shopify_user_id
        @sub.to_i if user_id_sub? && admin_session_token?
      end

      alias_method :eql?, :==
      sig { params(other: T.nilable(JwtPayload)).returns(T::Boolean) }
      def ==(other)
        return false unless other

        iss == other.iss &&
          dest == other.dest &&
          aud == other.aud &&
          sub == other.sub &&
          exp == other.exp &&
          nbf == other.nbf &&
          iat == other.iat &&
          jti == other.jti &&
          sid == other.sid
      end

      private

      sig { params(token: String, api_secret_key: String).returns(T::Hash[String, T.untyped]) }
      def decode_token(token, api_secret_key)
        JWT.decode(token, api_secret_key, true, leeway: JWT_LEEWAY, algorithm: "HS256")[0]
      rescue JWT::DecodeError => err
        raise ShopifyAPI::Errors::InvalidJwtTokenError, "Error decoding session token: #{err.message}"
      end

      sig { returns(T::Boolean) }
      def admin_session_token?
        @iss.end_with?("/admin")
      end

      sig { returns(T::Boolean) }
      def user_id_sub?
        @sub&.match?(/\A\d+\z/) || false
      end
    end
  end
end
