# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class JwtPayload
      extend T::Sig

      JWT_EXPIRATION_LEEWAY = 5

      sig { returns(String) }
      attr_reader :iss, :dest, :aud, :sub, :jti, :sid

      sig { returns(Integer) }
      attr_reader :exp, :nbf, :iat

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
        @sub = T.let(payload_hash["sub"], String)
        @exp = T.let(payload_hash["exp"], Integer)
        @nbf = T.let(payload_hash["nbf"], Integer)
        @iat = T.let(payload_hash["iat"], Integer)
        @jti = T.let(payload_hash["jti"], String)
        @sid = T.let(payload_hash["sid"], String)

        raise ShopifyAPI::Errors::InvalidJwtTokenError,
          "Session token had invalid API key" unless @aud == Context.api_key
      end

      sig { returns(String) }
      def shop
        @dest.gsub("https://", "")
      end

      # TODO: Remove before releasing v11
      sig { params(shop: String).returns(T::Boolean) }
      def validate_shop(shop)
        Context.logger.warn(
          "Deprecation notice: ShopifyAPI::Auth::JwtPayload.validate_shop no longer checks the given shop and always " \
            "returns true. It will be removed in v11."
        )
        true
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
        JWT.decode(token, api_secret_key, true,
          { exp_leeway: JWT_EXPIRATION_LEEWAY, algorithm: "HS256" })[0]
      rescue
        raise ShopifyAPI::Errors::InvalidJwtTokenError, "Failed to parse session token '#{token}'"
      end
    end
  end
end
