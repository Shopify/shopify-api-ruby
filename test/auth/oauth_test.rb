# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

class OauthTest < Test::Unit::TestCase
  ALPHANUMERIC_REGEX = /\A[a-zA-Z0-9]*\z/

  def setup
    super()

    @stubbed_time_now = Time.now
    @shop = "test-shop.myshopify.com"
    @session_cookie = "cookie-id"
    @cookies = { ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME => @session_cookie }
    @callback_code = "auth-query-code"
    @callback_timestamp = Time.now.to_i.to_s
    @callback_state = "nonce"
    @callback_hmac = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha256"),
      ShopifyAPI::Context.api_secret_key,
      URI.encode_www_form({
        code: @callback_code,
        host: HOST_NAME,
        shop: @shop,
        state: @callback_state,
        timestamp: @callback_timestamp,
      })
    )
    @auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(code: @callback_code, shop: @shop,
      timestamp: @callback_timestamp, host: HOST_NAME, state: @callback_state, hmac: @callback_hmac)
    @access_token_request = {
      client_id: ShopifyAPI::Context.api_key,
      client_secret: ShopifyAPI::Context.api_secret_key,
      code: @callback_code,
    }

    @offline_token_response = {
      access_token: SecureRandom.alphanumeric(10),
      scope: "scope1,scope2",
    }
    @online_token_response = {
      access_token: SecureRandom.alphanumeric(10),
      scope: "scope1,scope2",
      expires_in: 1000,
      associated_user_scope: "scope1",
      associated_user: {
        id: 902541635,
        first_name: "first",
        last_name: "last",
        email: "firstlast@example.com",
        email_verified: true,
        account_owner: true,
        locale: "en",
        collaborator: false,
      },
    }

    @expected_associated_user = ShopifyAPI::Auth::AssociatedUser.new(
      id: @online_token_response[:associated_user][:id],
      first_name: @online_token_response[:associated_user][:first_name],
      last_name: @online_token_response[:associated_user][:last_name],
      email: @online_token_response[:associated_user][:email],
      email_verified: @online_token_response[:associated_user][:email_verified],
      account_owner: @online_token_response[:associated_user][:account_owner],
      locale: @online_token_response[:associated_user][:locale],
      collaborator: @online_token_response[:associated_user][:collaborator],
    )
  end

  def test_begin_auth_for_offline_token
    result = ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect", is_online: false)
    verify_oauth_begin(auth_route: result[:auth_route], cookie: result[:cookie], is_online: false)
  end

  def test_begin_auth_online
    result = ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect")
    verify_oauth_begin(auth_route: result[:auth_route], cookie: result[:cookie], is_online: true)
  end

  def test_begin_auth_private_app
    modify_context(is_private: true)

    assert_raises(ShopifyAPI::Errors::UnsupportedOauth) do
      ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect")
    end
  end

  def test_begin_auth_with_session_store_save_error
    modify_context(session_storage: TestHelpers::FakeSessionStorage.new(error_on_save: true))

    assert_raises(ShopifyAPI::Errors::SessionStorage) do
      ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect")
    end
  end

  def test_validate_auth_callback_offline
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
      .with(body: @access_token_request)
      .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })

    expected_session = ShopifyAPI::Auth::Session.new(id: @session_cookie, shop: @shop,
      access_token: @offline_token_response[:access_token], scope: @offline_token_response[:scope].split(","))
    expected_cookie = ShopifyAPI::Auth::Oauth::SessionCookie.new(value: @session_cookie, expires: nil)

    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state))
    got = ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)

    verify_oauth_complete(got: got, expected_session: expected_session, expected_cookie: expected_cookie)
  end

  def test_validate_auth_callback_offline_embedded
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
      .with(body: @access_token_request)
      .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })

    expected_session = ShopifyAPI::Auth::Session.new(id: "offline_#{@shop}", shop: @shop,
      access_token: @offline_token_response[:access_token], scope: @offline_token_response[:scope].split(","))
    expected_cookie = ShopifyAPI::Auth::Oauth::SessionCookie.new(value: "", expires: @stubbed_time_now)

    modify_context(is_embedded: true)
    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state))

    got = Time.stub(:now, @stubbed_time_now) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end

    verify_oauth_complete(got: got, expected_session: expected_session, expected_cookie: expected_cookie)
  end

  def test_validate_auth_callback_online
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
      .with(body: @access_token_request)
      .to_return(body: @online_token_response.to_json, headers: { content_type: "application/json" })

    expected_session = ShopifyAPI::Auth::Session.new(
      id: @session_cookie,
      shop: @shop,
      access_token: @online_token_response[:access_token],
      scope: @online_token_response[:scope].split(","),
      associated_user_scope: @online_token_response[:associated_user_scope].split(","),
      expires: @stubbed_time_now + @online_token_response[:expires_in].to_i,
      associated_user: @expected_associated_user
    )
    expected_cookie = ShopifyAPI::Auth::Oauth::SessionCookie.new(value: expected_session.id,
      expires: expected_session.expires)

    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state, is_online: true))
    got = Time.stub(:now, @stubbed_time_now) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end

    verify_oauth_complete(got: got, expected_session: expected_session, expected_cookie: expected_cookie)
  end

  def test_validate_auth_callback_online_embedded
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
      .with(body: @access_token_request)
      .to_return(body: @online_token_response.to_json, headers: { content_type: "application/json" })

    expected_session = ShopifyAPI::Auth::Session.new(
      id: "#{@shop}_#{@expected_associated_user.id}",
      shop: @shop,
      access_token: @online_token_response[:access_token],
      scope: @online_token_response[:scope].split(","),
      associated_user_scope: @online_token_response[:associated_user_scope].split(","),
      expires: @stubbed_time_now + @online_token_response[:expires_in].to_i,
      associated_user: @expected_associated_user
    )
    expected_cookie = ShopifyAPI::Auth::Oauth::SessionCookie.new(
      value: "",
      expires: @stubbed_time_now
    )

    modify_context(is_embedded: true)
    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state, is_online: true))
    got = Time.stub(:now, @stubbed_time_now) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end

    verify_oauth_complete(got: got, expected_session: expected_session, expected_cookie: expected_cookie)
  end

  def test_validate_auth_callback_invalid_hmac
    auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(code: @callback_code, shop: @shop,
      timestamp: @callback_timestamp, host: HOST_NAME, state: @callback_state, hmac: "")

    assert_raises(ShopifyAPI::Errors::InvalidOauthError) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: auth_query)
    end
  end

  def test_validate_auth_private_app
    modify_context(is_private: true)

    assert_raises(ShopifyAPI::Errors::UnsupportedOauth) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end
  end

  def test_validate_auth_no_session_cookie
    assert_raises(ShopifyAPI::Errors::NoSessionCookieError) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: {}, auth_query: @auth_query)
    end
  end

  def test_validate_auth_callback_no_saved_session
    assert_raises(ShopifyAPI::Errors::SessionNotFoundError) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end
  end

  def test_validate_auth_callback_invalid_state
    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state + "invalid"))
    assert_raises(ShopifyAPI::Errors::InvalidOauthError) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end
  end

  def test_validate_auth_callback_delete_session_fails
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
      .with(body: @access_token_request)
      .to_return(body: @online_token_response.to_json, headers: { content_type: "application/json" })

    modify_context(is_embedded: true, session_storage: TestHelpers::FakeSessionStorage.new(error_on_delete: true))
    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state, is_online: true))
    assert_raises(ShopifyAPI::Errors::SessionStorage) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end
  end

  def test_validate_auth_callback_bad_http_response
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token").to_return(status: 500)

    ShopifyAPI::Context.session_storage.store_session(ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
      state: @callback_state))
    assert_raises(ShopifyAPI::Errors::RequestAccessTokenError) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end
  end

  def test_validate_auth_callback_save_session_fails
    stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
      .with(body: @access_token_request)
      .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })

    modify_context(is_embedded: true, session_storage: TestHelpers::FakeSessionStorage.new(
      sessions: { @session_cookie => ShopifyAPI::Auth::Session.new(shop: @shop, id: @session_cookie,
        state: @callback_state) }, error_on_save: true
    ))
    assert_raises(ShopifyAPI::Errors::SessionStorage) do
      ShopifyAPI::Auth::Oauth.validate_auth_callback(cookies: @cookies, auth_query: @auth_query)
    end
  end

  private

  def verify_oauth_begin(auth_route:, cookie:, is_online:)
    expected_query_params = {
      client_id: API_KEY,
      scope: SCOPE.join(","),
      redirect_uri: "https://#{HOST_NAME}/redirect",
      "grant_options[]": is_online ? "per-user" : "",
    }

    result_uri = URI.parse(auth_route)
    result_query_params = CGI.parse(result_uri.query).map { |k, v| [k.to_sym, v.first] }.to_h
    result_state = result_query_params.delete(:state)

    assert_equal(15, result_state.length)
    assert(ALPHANUMERIC_REGEX.match?(result_state))

    assert_equal("https", result_uri.scheme)
    assert_equal(@shop, result_uri.host)
    assert_equal("/admin/oauth/authorize", result_uri.path)
    assert_equal(expected_query_params, result_query_params)

    assert_equal(cookie.value, T.must(ShopifyAPI::Context.session_storage.load_session(cookie.value)).id)
  end

  def verify_oauth_complete(got:, expected_session:, expected_cookie:)
    assert_equal(expected_session, got[:session])
    assert_equal(expected_session, ShopifyAPI::Context.session_storage.sessions[expected_session.id])
    assert_equal(expected_cookie, got[:cookie])
  end
end
