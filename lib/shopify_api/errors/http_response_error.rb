# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Errors
    class HttpResponseError < StandardError
      extend T::Sig

      sig { returns(Integer) }
      attr_reader :code

      sig { returns(T.untyped) }
      attr_reader :errors

      sig { params(code: Integer, errors: T.untyped).void }
      def initialize(code:, errors: {})
        super
        @code = code
        @errors = errors
      end
    end
  end
end
