# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Rest
    class BaseErrors
      extend T::Sig

      sig { returns(T::Array[T.untyped]) }
      attr_accessor :errors

      sig { void }
      def initialize
        @errors = T.let([], T::Array[Rest::BaseErrors])
      end

      sig { returns(String) }
      def full_messages
        @errors.join("\n")
      end
    end
  end
end
