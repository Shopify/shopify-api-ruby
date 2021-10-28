# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module SessionStorage
      extend T::Sig
      extend T::Helpers
      interface!

      sig do
        abstract.params(session: Session)
          .returns(T::Boolean)
      end
      def store_session(session); end

      sig do
        abstract.params(id: String)
          .returns(T.nilable(Session))
      end
      def load_session(id); end

      sig do
        abstract.params(id: String)
          .returns(T::Boolean)
      end
      def delete_session(id); end
    end
  end
end
