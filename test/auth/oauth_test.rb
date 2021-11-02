# typed: true
# frozen_string_literal: true

require_relative "../test_helper"

class OauthTest < Test::Unit::TestCase
  ALPHANUMERIC_REGEX = /\A[a-zA-Z0-9]*\z/

  def setup
    super()
    @shop = "test-shop.myshopify.com"
  end

  def test_begin_auth_for_offline_token
    result = ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect", is_online: false)
    verify(auth_route: result[:auth_route], cookie: result[:cookie], is_online: false)
  end

  def test_begin_auth_online
    result = ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect")
    verify(auth_route: result[:auth_route], cookie: result[:cookie], is_online: true)
  end

  def test_begin_auth_with_session_store_save_error
    ShopifyAPI::Context.setup(
      api_key: API_KEY,
      api_secret_key: API_SECRET_KEY,
      host_name: HOST_NAME,
      scope: SCOPE,
      session_storage: TestHelpers::FakeSessionStorage.new(sessions: {}, error_on_save: true)
    )

    assert_raises(ShopifyAPI::SessionStorageError) do
      ShopifyAPI::Auth::Oauth.begin_auth(shop: @shop, redirect_path: "/redirect")
    end
  end

  private

  def verify(auth_route:, cookie:, is_online:)
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
end
