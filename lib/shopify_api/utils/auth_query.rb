# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    class AuthQuery
      extend T::Sig
      include VerifiableQuery

      sig { returns(String) }
      attr_reader :code, :shop, :timestamp, :state

      sig { returns(T.nilable(String)) }
      attr_reader :host, :hmac

      sig do
        params(
          code: String,
          shop: String,
          timestamp: String,
          state: String,
          host: T.nilable(String),
          hmac: T.nilable(String)
        ).void
      end
      def initialize(code:, shop:, timestamp:, state:, host: nil, hmac: nil)
        @code = code
        @shop = shop
        @timestamp = timestamp
        @state = state
        @host = host
        @hmac = hmac
      end

      sig { override.returns(T::Hash[Symbol, String]) }
      def to_signable_hash
        params = {}
        params[:code] = @code
        params[:shop] = @shop
        params[:state] = @state
        params[:timestamp] = @timestamp
        params[:host] = @host if @host
        params
      end
    end
  end
end
