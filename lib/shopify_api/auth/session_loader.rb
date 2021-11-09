# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    class SessionLoader
      extend T::Sig

      class << self
        extend T::Sig

        sig do
          params(
            headers: T::Hash[Symbol, String],
            cookies: T.nilable(T::Hash[Symbol, String]),
            online: T::Boolean
          ).returns(T.nilable(Session))
        end
        def load_current_session(headers:, cookies:, online:)
          session_id = current_seesion_id(headers, cookies, online)
          return nil unless session_id
          Context.session_storage.load_session(session_id)
        end

        private

        sig do
          params(
            headers: T::Hash[Symbol, String],
            cookies: T.nilable(T::Hash[Symbol, String]),
            online: T::Boolean
          ).returns(T.nilable(String))
        end
        def current_seesion_id(headers, cookies, online)
          if Context.is_embedded
            if headers[:authorization]
              matches = T.must(headers[:authorization]).match(/^Bearer (.+)$/)
              raise ShopifyAPI::Errors::MissingJwtTokenError,
                "Missing Bearer token in authorization header" unless matches

              jwt_payload = ShopifyAPI::Auth::JwtPayload.new(T.must(matches[1]))
              shop = jwt_payload.shop

              if online
                jwt_session_id(shop, jwt_payload.sub)
              else
                offline_session_id(shop)
              end
            else
              # falling back to session cookie
              raise ShopifyAPI::Errors::CookieNotFoundError, "JWT token or Session cookie not found for app" unless
                cookies && cookies[ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME.to_sym]
              cookie_session_id(cookies)
            end
          else
            raise ShopifyAPI::Errors::CookieNotFoundError, "Session cookie not found for app" unless
              cookies && cookies[ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME.to_sym]
            cookie_session_id(cookies)
          end
        end

        sig { params(shop: String, user_id: String).returns(String) }
        def jwt_session_id(shop, user_id)
          "#{shop}_#{user_id}"
        end

        sig { params(shop: String).returns(String) }
        def offline_session_id(shop)
          "offline_#{shop}"
        end

        sig { params(cookies: T::Hash[Symbol, String]).returns(T.nilable(String)) }
        def cookie_session_id(cookies)
          cookies[ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME.to_sym]
        end
      end
    end
  end
end
