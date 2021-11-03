# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    module VerifiableQuery
      extend T::Sig
      extend T::Helpers
      interface!

      sig { abstract.returns(T.nilable(String)) }
      def hmac(); end

      sig { abstract.returns(T::Hash[Symbol, String]) }
      def to_signable_hash(); end
    end
  end
end
