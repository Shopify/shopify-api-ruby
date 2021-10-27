# typed: true
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class Session
      extend T::Sig

      sig { returns(String) }
      attr_reader :id

      sig { returns(T.nilable(String)) }
      attr_accessor :state, :access_token

      sig { returns(String) }
      attr_accessor :shop

      sig { returns(T::Array[String]) }
      attr_accessor :scope

      sig { returns(T.nilable(Integer)) }
      attr_accessor :expires

      sig { returns(T.nilable(AssociatedUser)) }
      attr_accessor :associated_user

      sig { returns(T::Boolean) }
      attr_accessor :is_online

      sig do
        params(
          shop: String,
          id: T.nilable(String),
          state: T.nilable(String),
          access_token: T.nilable(String),
          scope: T::Array[String],
          expires: T.nilable(Integer),
          is_online: T.nilable(T::Boolean),
          associated_user: T.nilable(AssociatedUser)
        ).void
      end
      def initialize(shop:, id: nil, state: nil, access_token: "", scope: [], expires: nil, is_online: nil, associated_user: nil)
        @id = id || SecureRandom.uuid
        @shop = shop
        @state = state
        @access_token = access_token
        @scope = scope
        @expires = expires
        @associated_user = associated_user
        @is_online = is_online || !associated_user.nil?
      end
    end
  end
end
