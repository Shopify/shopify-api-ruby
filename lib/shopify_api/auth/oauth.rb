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
          unless Context.setup?
            raise Errors::ContextNotSetupError, "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end
          raise Errors::UnsupportedOauthError, "Cannot perform OAuth for private apps." if Context.private?

          state = SecureRandom.alphanumeric(NONCE_LENGTH)
          session = Session.new(shop: shop, state: state, is_online: is_online)

          store_session(session)

          cookie = SessionCookie.new(value: session.id, expires: Time.now + 60)

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

        sig do
          params(
            cookies: T::Hash[Symbol, String],
            auth_query: AuthQuery
          ).returns(T::Hash[Symbol, T.any(Session, T.nilable(SessionCookie))])
        end
        def validate_auth_callback(cookies:, auth_query:)
          unless Context.setup?
            raise Errors::ContextNotSetupError, "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end
          raise Errors::InvalidOauthError, "Invalid OAuth callback." unless Utils::HmacValidator.validate(auth_query)
          raise Errors::UnsupportedOauthError, "Cannot perform OAuth for private apps." if Context.private?

          session_cookie = cookies[SessionCookie::SESSION_COOKIE_NAME.to_sym]
          raise Errors::NoSessionCookieError unless session_cookie

          session_storage = ShopifyAPI::Context.session_storage

          current_session = session_storage.load_session(session_cookie)

          unless current_session
            raise Errors::SessionNotFoundError,
              "Cannot complete OAuth process. No session found for the specified shop url: #{auth_query.shop}"
          end

          raise Errors::InvalidOauthError,
            "Invalid state in OAuth callback." unless current_session.state == auth_query.state

          # TODO: replace this call with the HTTP client once it is built
          body = { client_id: Context.api_key, client_secret: Context.api_secret_key, code: auth_query.code }
          response = HTTParty.post("https://#{auth_query.shop}/admin/oauth/access_token", body: body)
          unless response.ok?
            raise Errors::RequestAccessTokenError,
              "Cannot complete OAuth process. Received a #{response.code} error while requesting access token."
          end
          session_params = response.to_h

          new_session = create_new_session(session_params, current_session)

          cookie = nil
          if Context.embedded?
            unless session_storage.delete_session(session_cookie)
              raise Errors::SessionStorageError,
                "OAuth Session could not be deleted. Please check your session storage functionality."
            end

            cookie = SessionCookie.new(
              value: "",
              expires: Time.now
            )
          else
            cookie = SessionCookie.new(
              value: new_session.id,
              expires: new_session.online? ? new_session.expires : nil
            )
          end

          store_session(new_session)

          { session: new_session, cookie: cookie }
        end

        private

        sig { params(session: Session).void }
        def store_session(session)
          session_stored = Context.session_storage.store_session(session)
          unless session_stored
            raise Errors::SessionStorageError,
              "Session could not be saved. Please check your session storage implementation."
          end
        end

        sig { params(session_params: T::Hash[String, T.untyped], current_session: Session).returns(Session) }
        def create_new_session(session_params, current_session)
          session_params = session_params.map { |k, v| [k.to_sym, v] }.to_h

          id = current_session.id
          scope = session_params[:scope].split(",")

          if current_session.online?
            associated_user = AssociatedUser.new(session_params[:associated_user].map { |k, v| [k.to_sym, v] }.to_h)
            expires = Time.now + session_params[:expires_in].to_i
            associated_user_scope = session_params[:associated_user_scope].split(",")
            id = "#{current_session.shop}_#{associated_user.id}" if Context.embedded?
          end

          id = "offline_#{current_session.shop}" if Context.embedded? && !current_session.online?

          Session.new(
            id: id,
            shop: current_session.shop,
            access_token: session_params[:access_token],
            scope: scope,
            associated_user_scope: associated_user_scope,
            associated_user: associated_user,
            expires: expires
          )
        end
      end
    end
  end
end
