require 'test_helper'
require "active_support/log_subscriber/test_helper"
require 'json'

class LogSubscriberTest < Test::Unit::TestCase
  include ActiveSupport::LogSubscriber::TestHelper

  attr_reader :request_headers

  def setup
    super
    @page = { page: { id: 1, title: 'Shopify API' } }.to_json
    @ua_header = "\"User-Agent\"=>\"ShopifyAPI/#{ShopifyAPI::VERSION} ActiveResource/#{ActiveResource::VERSION::STRING} Ruby/#{RUBY_VERSION}\""
    @request_headers = "Headers: {\"Accept\"=>\"application/json\", " \
      "#{@ua_header}, \"X-Shopify-Access-Token\"=>\"access_token\"}"

    ShopifyAPI::Base.clear_session
    fake("apis",
      url: "https://app.shopify.com/services/apis.json",
      method: :get,
      status: 200,
      api_version: :stub,
      body: load_fixture('apis'))
    ShopifyAPI::ApiVersion.fetch_known_versions
    session = ShopifyAPI::Session.new(
      domain: "https://this-is-my-test-shop.myshopify.com",
      token: "access_token",
      api_version: '2019-01'
    )

    ShopifyAPI::Base.activate_session(session)

    ActiveResource::LogSubscriber.attach_to(:active_resource)
    ActiveResource::DetailedLogSubscriber.attach_to(:active_resource_detailed)
  end

  def teardown
    super
    ShopifyAPI::ApiVersion.clear_known_versions
    ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown
  end

  def set_logger(logger)
    ActiveResource::Base.logger = logger
  end

  test "logging on #find" do
    fake "pages/1", method: :get, body: @page

    ShopifyAPI::Page.find(1)

    assert_equal(4, @logger.logged(:info).size)
    assert_equal(
      "GET https://this-is-my-test-shop.myshopify.com:443/admin/api/2019-01/pages/1.json",
      @logger.logged(:info)[0]
    )
    assert_match(/\-\-\> 200/, @logger.logged(:info)[1])
    assert_equal(request_headers, @logger.logged(:info)[2])
    assert_match(
      %r{(Response:\n\{\"page\"\:\{\"id\"\:1,\"title\"\:\"Shopify API\"\}\})|
        (Response:\n\{\"page\"\:\{\"title\"\:\"Shopify API\",\"id\"\:1\}\})},
      @logger.logged(:info)[3]
    )
  end

  test "logging on #find with an error" do
    fake "pages/2", method: :get, body: nil, status: 404

    assert_raises ActiveResource::ResourceNotFound do
      ShopifyAPI::Page.find(2)
    end

    if ar_version_before?('5.1.0')
      assert_equal(4, @logger.logged(:info).size)
      assert_equal(
        "GET https://this-is-my-test-shop.myshopify.com:443/admin/api/2019-01/pages/2.json",
        @logger.logged(:info)[0]
      )
      assert_match(/\-\-\> 404/, @logger.logged(:info)[1])
      assert_equal(request_headers, @logger.logged(:info)[2])
      assert_equal("Response:", @logger.logged(:info)[3])
    else
      assert_equal(2, @logger.logged(:error).size)
      assert_equal(
        "GET https://this-is-my-test-shop.myshopify.com:443/admin/api/2019-01/pages/2.json",
        @logger.logged(:error)[0]
      )
      assert_match(/\-\-\> 404/, @logger.logged(:error)[1])

      assert_equal(2, @logger.logged(:info).size)
      assert_equal(request_headers, @logger.logged(:info)[0])
      assert_equal("Response:", @logger.logged(:info)[1])
    end
  end

  test "warns when the server responds with a x-shopify-api-deprecated-reason header" do
    fake(
      "pages/1",
      method: :get,
      body: @page,
      x_shopify_api_deprecated_reason: 'https://help.shopify.com/en/api/getting-started/api-deprecations'
    )

    ShopifyAPI::Page.find(1)

    assert_equal 1, @logger.logged(:warn).size

    assert_match(
      %r{\[DEPRECATED\] ShopifyAPI made a call to GET /admin/api/2019-01/pages/1.json},
      @logger.logged(:warn).first
    )
    assert_match(
      %r{See https:\/\/help.shopify.com\/en\/api\/getting-started\/api-deprecations for more details.},
      @logger.logged(:warn).first
    )
  end

  test "warns when the server responds with a x-shopify-api-version-warning header" do
    fake(
      "pages/1",
      method: :get,
      body: @page,
      x_shopify_api_version_warning: 'https://shopify.dev/concepts/about-apis/versioning'
    )

    ShopifyAPI::Page.find(1)

    assert_equal 1, @logger.logged(:warn).size

    assert_match(
      %r{\[API Version Warning\] ShopifyAPI made a call to GET /admin/api/2019-01/pages/1.json},
      @logger.logged(:warn).first
    )
    assert_match(
      %r{See https:\/\/shopify.dev\/concepts\/about-apis\/versioning for more details.},
      @logger.logged(:warn).first
    )
  end
end
