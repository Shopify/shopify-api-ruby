# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    module HmacValidator
      extend T::Sig

      class << self
        extend T::Sig

        sig do
          params(
            verifiable_query: VerifiableQuery,
            config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
          ).returns(T::Boolean)
        end
        def validate(verifiable_query, config = ShopifyAPI::Context)
          return false unless verifiable_query.hmac

          result = validate_signature(verifiable_query, config.api_secret_key)
          if result || config.old_api_secret_key.blank?
            result
          else
            validate_signature(verifiable_query, T.must(config.old_api_secret_key))
          end
        end

        private

        sig { params(verifiable_query: VerifiableQuery, secret: String).returns(T::Boolean) }
        def validate_signature(verifiable_query, secret)
          received_signature = verifiable_query.hmac
          computed_signature = compute_signature(verifiable_query.to_signable_string, secret)
          OpenSSL.secure_compare(computed_signature, received_signature)
        end

        sig { params(signable_string: String, secret: String).returns(String) }
        def compute_signature(signable_string, secret)
          OpenSSL::HMAC.hexdigest(
            OpenSSL::Digest.new("sha256"),
            secret,
            signable_string,
          )
        end
      end
    end
  end
end
