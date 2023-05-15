# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    class SessionUtils
      extend T::Sig

      class << self
        extend T::Sig

        sig do
          params(
            auth_header: T.nilable(String),
            cookies: T.nilable(T::Hash[String, String]),
            online: T::Boolean,
          ).returns(T.nilable(String))
        end
        def current_session_id(auth_header, cookies, online)
          if Context.embedded?
            if auth_header
              matches = auth_header.match(/^Bearer (.+)$/)
              unless matches
                ShopifyAPI::Logger.warn("Missing Bearer token in authorization header")
                raise Errors::MissingJwtTokenError, "Missing Bearer token in authorization header"
              end

              jwt_payload = Auth::JwtPayload.new(T.must(matches[1]))
              shop = jwt_payload.shop

              if online
                jwt_session_id(shop, jwt_payload.sub)
              else
                offline_session_id(shop)
              end
            else
              # falling back to session cookie
              raise Errors::CookieNotFoundError, "JWT token or Session cookie not found for app" unless
                cookies && cookies[Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME]

              cookie_session_id(cookies)
            end
          else
            raise Errors::CookieNotFoundError, "Session cookie not found for app" unless
              cookies && cookies[Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME]

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

        sig { params(cookies: T::Hash[String, String]).returns(T.nilable(String)) }
        def cookie_session_id(cookies)
          cookies[Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME]
        end
      end
    end
  end
end
