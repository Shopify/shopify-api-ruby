# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Errors
    class HttpResponseError < StandardError
      extend T::Sig

      sig { returns(Integer) }
      attr_reader :code

      sig { params(code: Integer).void }
      def initialize(code:)
        super
        @code = code
      end
    end
  end
end
