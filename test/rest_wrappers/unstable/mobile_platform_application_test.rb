# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class MobilePlatformApplicationUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MobilePlatformApplication.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({platform: "ios", application_id: "X1Y2.ca.domain.app", enabled_universal_or_app_links: true, enabled_shared_webcredentials: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new(session: @test_session)
    mobile_platform_application.platform = "ios"
    mobile_platform_application.application_id = "X1Y2.ca.domain.app"
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = true
    mobile_platform_application.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({platform: "android", application_id: "com.example", sha256_cert_fingerprints: ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], enabled_universal_or_app_links: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new(session: @test_session)
    mobile_platform_application.platform = "android"
    mobile_platform_application.application_id = "com.example"
    mobile_platform_application.sha256_cert_fingerprints = [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176000.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MobilePlatformApplication.find(
      session: @test_session,
      id: "1066176000",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176000.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176001.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({id: 1066176001, application_id: "A1B2.ca.domain.app", platform: "ios", created_at: "2022-01-06T16:31:43-05:00", updated_at: "2022-01-06T16:31:43-05:00", sha256_cert_fingerprints: [], enabled_universal_or_app_links: true, enabled_shared_webcredentials: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new(session: @test_session)
    mobile_platform_application.id = 1066176001
    mobile_platform_application.application_id = "A1B2.ca.domain.app"
    mobile_platform_application.platform = "ios"
    mobile_platform_application.created_at = "2022-01-06T16:31:43-05:00"
    mobile_platform_application.updated_at = "2022-01-06T16:31:43-05:00"
    mobile_platform_application.sha256_cert_fingerprints = []
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = true
    mobile_platform_application.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176001.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176002.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({id: 1066176002, application_id: "com.example.news.app", platform: "android", created_at: "2022-01-06T16:31:45-05:00", updated_at: "2022-01-06T16:31:45-05:00", sha256_cert_fingerprints: ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], enabled_universal_or_app_links: true, enabled_shared_webcredentials: false}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new(session: @test_session)
    mobile_platform_application.id = 1066176002
    mobile_platform_application.application_id = "com.example.news.app"
    mobile_platform_application.platform = "android"
    mobile_platform_application.created_at = "2022-01-06T16:31:45-05:00"
    mobile_platform_application.updated_at = "2022-01-06T16:31:45-05:00"
    mobile_platform_application.sha256_cert_fingerprints = [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = false
    mobile_platform_application.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176002.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176003.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::MobilePlatformApplication.delete(
      session: @test_session,
      id: "1066176003",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/mobile_platform_applications/1066176003.json")
  end

end
