# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module ClientAssertion
      extend T::Sig

      DEFAULT_LIFETIME_SECONDS = 60
      # Mirrors Shopify's own bound: an assertion whose `exp - iat` is more than 5 minutes is rejected, and
      # exactly 300 seconds is accepted. Check this value against
      # https://shopify.dev/docs/apps/build/authentication-authorization/application-only-access-tokens
      # before changing it.
      MAX_LIFETIME_SECONDS = 300
      RSA_ALGORITHM = "RS256"
      EC_ALGORITHM = "ES256"
      MIN_RSA_KEY_BITS = 2048
      # Shopify accepts a `kid` of at most 255 characters, so a longer one can never match.
      MAX_KID_LENGTH = 255
      SUPPORTED_EC_CURVES = T.let(["prime256v1", "secp256r1"].freeze, T::Array[String])
      PERMANENT_SHOP_DOMAIN = /\A[a-z0-9][a-z0-9_-]*\.myshopify\.com\z/
      MYSHOPIFY_DOMAIN = "myshopify.com"

      class << self
        extend T::Sig

        sig do
          params(
            shop: String,
            kid: String,
            private_key: T.any(OpenSSL::PKey::RSA, OpenSSL::PKey::EC),
            client_id: T.nilable(String),
            lifetime_seconds: Integer,
            audience: T.nilable(String),
          ).returns(String)
        end
        def create(
          shop:,
          kid:,
          private_key:,
          client_id: nil,
          lifetime_seconds: DEFAULT_LIFETIME_SECONDS,
          audience: nil
        )
          audience = audience.nil? ? audience_for(shop) : validated_audience(audience)
          # The only value read from `ShopifyAPI::Context`, and only when the caller omits it. The server
          # requires `iss` and `sub` to equal the `client_id` the request posts, which is `Context.api_key`.
          client_id = Context.api_key if client_id.nil?
          client_id = validated_value(client_id, "client_id")
          kid = validated_kid(kid)
          validate_lifetime!(lifetime_seconds)
          signing_key, algorithm = validated_key_with_algorithm(private_key)

          issued_at = Time.now.to_i
          claims = {
            "iss" => client_id,
            "sub" => client_id,
            "aud" => audience,
            "iat" => issued_at,
            "exp" => issued_at + lifetime_seconds,
            "jti" => SecureRandom.uuid,
          }

          JWT.encode(claims, signing_key, algorithm, { "kid" => kid, "typ" => "JWT" })
        end

        private

        # Only the shop's canonical permanent domain is accepted, so that the signer and
        # `ClientCredentials.client_credentials` agree on what a shop is. Case is normalized with ASCII
        # folding only: Unicode folding maps characters such as U+212A KELVIN SIGN onto ASCII letters, which
        # would turn one shop's name into another real shop's audience.
        sig { params(shop: String).returns(String) }
        def audience_for(shop)
          host = shop.strip.tr("A-Z", "a-z")
          unless PERMANENT_SHOP_DOMAIN.match?(host)
            raise Errors::InvalidClientAssertionError,
              "shop must be a permanent #{MYSHOPIFY_DOMAIN} domain in the form " \
                "{handle}.#{MYSHOPIFY_DOMAIN}, got: #{shop.inspect}"
          end

          ClientCredentials.token_endpoint_url(host)
        end

        sig { params(audience: String).returns(String) }
        def validated_audience(audience)
          validated_value(audience, "audience")
        end

        # Trimmed rather than rejected: a value read from a file or pasted from a terminal often carries a
        # newline, and the server matches `iss` and `kid` exactly, so an untrimmed value can only ever fail.
        sig { params(value: String, name: String).returns(String) }
        def validated_value(value, name)
          trimmed = value.strip
          raise Errors::InvalidClientAssertionError, "#{name} must be a non-empty String" if trimmed.empty?

          trimmed
        end

        sig { params(kid: String).returns(String) }
        def validated_kid(kid)
          trimmed = validated_value(kid, "kid")
          if trimmed.length > MAX_KID_LENGTH
            raise Errors::InvalidClientAssertionError,
              "kid must be at most #{MAX_KID_LENGTH} characters, got: #{trimmed.length}"
          end

          trimmed
        end

        sig { params(lifetime_seconds: Integer).void }
        def validate_lifetime!(lifetime_seconds)
          return if lifetime_seconds.positive? && lifetime_seconds <= MAX_LIFETIME_SECONDS

          raise Errors::InvalidClientAssertionError,
            "lifetime_seconds must be between 1 and #{MAX_LIFETIME_SECONDS}, got: #{lifetime_seconds}"
        end

        # Takes `Object` so that the checks below still run for an app that has turned sorbet-runtime's
        # call validation off.
        sig do
          params(private_key: Object).returns([T.any(OpenSSL::PKey::RSA, OpenSSL::PKey::EC), String])
        end
        def validated_key_with_algorithm(private_key)
          case private_key
          when OpenSSL::PKey::RSA
            unless private_key.private?
              raise Errors::InvalidClientAssertionError, "private_key must be an RSA private key, not a public key"
            end

            if private_key.n.num_bits < MIN_RSA_KEY_BITS
              raise Errors::InvalidClientAssertionError,
                "RSA private_key must be at least #{MIN_RSA_KEY_BITS} bits, got: #{private_key.n.num_bits}"
            end

            [private_key, RSA_ALGORITHM]
          when OpenSSL::PKey::EC
            unless private_key.private?
              raise Errors::InvalidClientAssertionError, "private_key must be an EC private key, not a public key"
            end

            unless SUPPORTED_EC_CURVES.include?(private_key.group.curve_name)
              raise Errors::InvalidClientAssertionError,
                "EC private_key must use the P-256 curve, got: #{private_key.group.curve_name}"
            end

            [private_key, EC_ALGORITHM]
          else
            raise Errors::InvalidClientAssertionError,
              "private_key must be an OpenSSL::PKey::RSA or OpenSSL::PKey::EC private key, " \
                "got: #{private_key.class}"
          end
        end
      end
    end
  end
end
