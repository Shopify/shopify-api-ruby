# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    module HmacValidator
      extend T::Sig

      class << self
        extend T::Sig

        sig { params(verifiable_query: VerifiableQuery).returns(T::Boolean) }
        def validate(verifiable_query)
          return false unless verifiable_query.hmac

          received_signature = verifiable_query.hmac
          computed_signature = compute_signature(verifiable_query.to_signable_string)
          OpenSSL.secure_compare(computed_signature, received_signature)
        end

        private

        sig { params(signable_string: String).returns(String) }
        def compute_signature(signable_string)
          OpenSSL::HMAC.hexdigest(
            OpenSSL::Digest.new("sha256"),
            ShopifyAPI::Context.api_secret_key,
            signable_string,
          )
        end
      end
    end
  end
end
