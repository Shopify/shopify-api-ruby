# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class MemorySessionStorage
      extend T::Sig
      extend T::Helpers
      include ShopifyAPI::Auth::SessionStorage

      sig { void }
      def initialize
        @sessions = T.let({}, T::Hash[String, Session])
      end

      sig do
        override.params(session: Session)
          .returns(T::Boolean)
      end
      def store_session(session)
        @sessions[session.id] = session
        true
      end

      sig do
        override.params(id: String)
          .returns(T.nilable(Session))
      end
      def load_session(id)
        @sessions[id]
      end

      sig do
        override.params(id: String)
          .returns(T::Boolean)
      end
      def delete_session(id)
        @sessions.delete(id)
        true
      end
    end
  end
end
