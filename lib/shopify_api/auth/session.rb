# typed: strict
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

      sig { returns(AuthScopes) }
      attr_accessor :scope

      sig { returns(T.nilable(AuthScopes)) }
      attr_accessor :associated_user_scope

      sig { returns(T.nilable(Time)) }
      attr_accessor :expires

      sig { returns(T.nilable(AssociatedUser)) }
      attr_accessor :associated_user

      sig { returns(T.nilable(String)) }
      attr_accessor :shopify_session_id

      sig { returns(T::Boolean) }
      def online?
        @is_online
      end

      sig { returns(T::Boolean) }
      def expired?
        @expires ? @expires < Time.now : false
      end

      sig do
        params(
          shop: String,
          id: T.nilable(String),
          state: T.nilable(String),
          access_token: T.nilable(String),
          scope: T.any(T::Array[String], String),
          associated_user_scope: T.nilable(T.any(T::Array[String], String)),
          expires: T.nilable(Time),
          is_online: T.nilable(T::Boolean),
          associated_user: T.nilable(AssociatedUser),
          shopify_session_id: T.nilable(String),
        ).void
      end
      def initialize(shop:, id: nil, state: nil, access_token: "", scope: [], associated_user_scope: nil, expires: nil,
        is_online: nil, associated_user: nil, shopify_session_id: nil)
        @id = T.let(id || SecureRandom.uuid, String)
        @shop = shop
        @state = state
        @access_token = access_token
        @scope = T.let(AuthScopes.new(scope), AuthScopes)
        @associated_user_scope = T.let(
          associated_user_scope.nil? ? nil : AuthScopes.new(associated_user_scope), T.nilable(AuthScopes)
        )
        @expires = expires
        @associated_user = associated_user
        @is_online = T.let(is_online || !associated_user.nil?, T::Boolean)
        @shopify_session_id = shopify_session_id
      end

      class << self
        extend T::Sig

        sig do
          params(shop: String, access_token: String,
            blk: T.proc.params(arg0: Session).returns(T.untyped)).returns(T.untyped)
        end
        def temp(shop:, access_token:, &blk)
          original_session = Context.active_session
          temp_session = Session.new(shop: shop, access_token: access_token)

          begin
            Context.activate_session(temp_session)
            yield temp_session
          ensure
            Context.activate_session(original_session)
          end
        end

        sig { params(str: String).returns(Session) }
        def deserialize(str)
          Oj.load(str)
        end
      end

      sig { returns(String) }
      def serialize
        Oj.dump(self)
      end

      alias_method :eql?, :==
      sig { params(other: T.nilable(Session)).returns(T::Boolean) }
      def ==(other)
        if other
          (
            id == other.id &&
            shop == other.shop &&
            state == other.state &&
            scope == other.scope &&
            associated_user_scope == other.associated_user_scope &&
            (!(expires.nil? ^ other.expires.nil?) && (expires.nil? || expires.to_i == other.expires.to_i)) &&
            online? == other.online? &&
            associated_user == other.associated_user &&
            shopify_session_id == other.shopify_session_id
          )
        else
          false
        end
      end
    end
  end
end
