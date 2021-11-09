# typed: true
# frozen_string_literal: true

require_relative "../test_helper"

class SessionLoaderTest < Test::Unit::TestCase
  def setup
    super
    @jwt_payload = {
      iss: "https://test-shop.myshopify.io/admin",
      dest: "https://test-shop.myshopify.io",
      aud: ShopifyAPI::Context.api_key,
      sub: "1",
      exp: (Time.now + 10).to_i,
      nbf: 1234,
      iat: 1234,
      jti: "4321",
      sid: "abc123",
    }
    @jwt_token = JWT.encode(@jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
    @jwt_headers = { authorization: "Bearer #{@jwt_token}" }
    @shop = "test-shop.myshopify.io"
  end

  def test_gets_the_current_session_from_cookies_for_non_embedded_apps
    cookie_id = "1234-this-is-a-cookie-session-id"
    cookies = { shopify_app_session: cookie_id }
    session = ShopifyAPI::Auth::Session.new(id: cookie_id, shop: @shop, is_online: true)
    ShopifyAPI::Context.session_storage.store_session(session)
    another_session = ShopifyAPI::Auth::Session.new(id: "some-random-id", shop: @shop, is_online: true)
    ShopifyAPI::Context.session_storage.store_session(another_session)
    loaded_session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers: {}, cookies: cookies, online: true)
    assert_equal(session, loaded_session)
  end

  def test_returns_nil_if_there_is_no_session_for_non_embedded_apps
    cookie_id = "1234-this-is-a-cookie-session-id"
    cookies = { shopify_app_session: cookie_id }
    assert_nil(ShopifyAPI::Auth::SessionLoader.load_current_session(
      headers: @jwt_headers,
      cookies: cookies,
      online: true
    ))
  end

  def test_gets_the_current_session_from_auth_header_for_embedded_apps
    modify_context(is_embedded: true)
    session_id = "#{@shop}_#{@jwt_payload[:sub]}"
    session = ShopifyAPI::Auth::Session.new(id: session_id, shop: @shop, is_online: true)
    ShopifyAPI::Context.session_storage.store_session(session)
    another_session = ShopifyAPI::Auth::Session.new(id: "some-random-id", shop: @shop, is_online: true)
    ShopifyAPI::Context.session_storage.store_session(another_session)
    loaded_session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers: @jwt_headers, cookies: {},
      online: true)
    assert_equal(session, loaded_session)
  end

  def test_loads_nothing_if_there_is_no_session_for_embedded_apps
    modify_context(is_embedded: true)
    loaded_session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers: @jwt_headers, cookies: {},
      online: true)
    assert_nil(loaded_session)
  end

  def test_fails_if_no_authorization_header_or_session_cookie_is_present
    modify_context(is_embedded: true)
    session_id = "#{@shop}_#{@jwt_payload[:sub]}"
    session = ShopifyAPI::Auth::Session.new(id: session_id, shop: @shop, is_online: true)
    ShopifyAPI::Context.session_storage.store_session(session)
    assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
      ShopifyAPI::Auth::SessionLoader.load_current_session(headers: {}, cookies: {}, online: true)
    end
  end

  def test_fails_if_authorization_header_bearer_token_is_invalid
    modify_context(is_embedded: true)
    session_id = "#{@shop}_#{@jwt_payload[:sub]}"
    session = ShopifyAPI::Auth::Session.new(id: session_id, shop: @shop, is_online: true)
    assert(ShopifyAPI::Context.session_storage.store_session(session))
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::SessionLoader.load_current_session(headers: { authorization: "Bearer invalid" }, cookies: {},
        online: true)
    end
  end

  def test_fails_if_authorization_header_is_not_a_bearer_token
    modify_context(is_embedded: true)
    session_id = "#{@shop}_#{@jwt_payload[:sub]}"
    session = ShopifyAPI::Auth::Session.new(id: session_id, shop: @shop, is_online: true)
    assert(ShopifyAPI::Context.session_storage.store_session(session))
    assert_raises(ShopifyAPI::Errors::MissingJwtTokenError) do
      ShopifyAPI::Auth::SessionLoader.load_current_session(headers: { authorization: "Not a Bearer token" },
        cookies: {}, online: true)
    end
  end

  def test_falls_back_to_the_cookie_session_for_embedded_apps
    modify_context(is_embedded: true)
    cookie_id = "1234-this-is-a-cookie-session-id"
    cookies = { shopify_app_session: cookie_id }
    session = ShopifyAPI::Auth::Session.new(id: cookie_id, shop: @shop, is_online: true)
    assert(ShopifyAPI::Context.session_storage.store_session(session))
    loaded_session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers: {}, cookies: cookies, online: true)
    assert_equal(session, loaded_session)
  end

  def test_loads_offline_sessions_from_cookies
    cookie_id = "offline_#{@shop}"
    cookies = { shopify_app_session: cookie_id }
    session = ShopifyAPI::Auth::Session.new(id: cookie_id, shop: @shop, is_online: false)
    assert(ShopifyAPI::Context.session_storage.store_session(session))
    loaded_session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers: {}, cookies: cookies, online: false)
    assert_equal(session, loaded_session)
  end

  def test_loads_offline_sessions_from_jwt_token
    modify_context(is_embedded: true)
    session = ShopifyAPI::Auth::Session.new(id: "offline_#{@shop}", shop: @shop, is_online: false)
    assert(ShopifyAPI::Context.session_storage.store_session(session))
    loaded_session = ShopifyAPI::Auth::SessionLoader.load_current_session(headers: @jwt_headers, cookies: {},
      online: false)
    assert_equal(session, loaded_session)
  end
end
