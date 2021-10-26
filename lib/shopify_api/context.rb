# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let(nil, T.nilable(String))
    @api_secret_key = T.let(nil, T.nilable(String))
    @host_name = T.let(nil, T.nilable(String))

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          host_name: T.nilable(String)
        ).void
      end
      def setup(api_key:, api_secret_key:, host_name: nil)
        @api_key = api_key
        @api_secret_key = api_secret_key
        @host_name = host_name
      end

      sig { returns(T.nilable(String)) }
      attr_reader :api_key, :api_secret_key, :host_name
    end
  end
end
