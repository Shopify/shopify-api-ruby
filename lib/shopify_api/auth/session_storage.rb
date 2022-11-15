# typed: strict
# frozen_string_literal: true

# rubocop:disable Layout/LineLength

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
      def store_session(session)
        ::ShopifyAPI::Context.logger.warn("ShopifyAPI::Auth::SessionStorage has been deprecated. The ShopifyAPI  will no longer have responsibility for session persistence. Consider using the `shopify_app` gem which now owns this responsiblity.")
      end

      sig do
        abstract.params(id: String)
          .returns(T.nilable(Session))
      end
      def load_session(id)
        ::ShopifyAPI::Context.logger.warn("ShopifyAPI::Auth::SessionStorage has been deprecated. The ShopifyAPI  will no longer have responsibility for session persistence. Consider using the `shopify_app` gem which now owns this responsiblity.")
      end

      sig do
        abstract.params(id: String)
          .returns(T::Boolean)
      end
      def delete_session(id)
        ::ShopifyAPI::Context.logger.warn("ShopifyAPI::Auth::SessionStorage has been deprecated. The ShopifyAPI  will no longer have responsibility for session persistence. Consider using the `shopify_app` gem which now owns this responsiblity.")
      end
    end
  end
end

# rubocop:enable Layout/LineLength
