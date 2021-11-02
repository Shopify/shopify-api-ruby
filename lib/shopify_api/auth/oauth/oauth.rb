# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module Oauth
      extend T::Sig

      NONCE_LENGTH = 15

      class << self
        extend T::Sig

        sig do
          params(
            shop: String,
            redirect_path: String,
            is_online: T.nilable(T::Boolean)
          ).returns(T::Hash[Symbol, T.any(String, SessionCookie)])
        end
        def begin_auth(shop:, redirect_path:, is_online: true)
          state = SecureRandom.alphanumeric(NONCE_LENGTH)
          session = Session.new(shop: shop, state: state, is_online: is_online)

          store_session(session)

          cookie = SessionCookie.new(value: session.id, expires: Time.now + 60_000)

          query = {
            client_id: ShopifyAPI::Context.api_key,
            scope: ShopifyAPI::Context.scope.join(","),
            redirect_uri: "https://#{ShopifyAPI::Context.host_name}#{redirect_path}",
            state: state,
            "grant_options[]": is_online ? "per-user" : "",
          }

          query_string = URI.encode_www_form(query)

          auth_route = "https://#{shop}/admin/oauth/authorize?#{query_string}"
          { auth_route: auth_route, cookie: cookie }
        end

        private

        sig { params(session: Session).void }
        def store_session(session)
          session_stored = Context.session_storage.store_session(session)
          unless session_stored
            raise SessionStorageError,
              "Session could not be saved. Please check your session storage implementation."
          end
        end
      end
    end
  end
end
