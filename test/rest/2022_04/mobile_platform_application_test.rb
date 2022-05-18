# typed: strict
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class MobilePlatformApplication202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_applications" => [{"id" => 1066175996, "application_id" => "X1Y2.ca.domain.app", "platform" => "ios", "created_at" => "2022-04-05T12:53:41-04:00", "updated_at" => "2022-04-05T12:53:41-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true}, {"id" => 1066175997, "application_id" => "com.example", "platform" => "android", "created_at" => "2022-04-05T12:53:41-04:00", "updated_at" => "2022-04-05T12:53:41-04:00", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false}]}), headers: {})

    ShopifyAPI::MobilePlatformApplication.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"platform" => "ios", "application_id" => "X1Y2.ca.domain.app", "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"id" => 1066175998, "application_id" => "X1Y2.ca.domain.app", "platform" => "ios", "created_at" => "2022-04-05T12:53:43-04:00", "updated_at" => "2022-04-05T12:53:43-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true}}), headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.platform = "ios"
    mobile_platform_application.application_id = "X1Y2.ca.domain.app"
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = true
    mobile_platform_application.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"platform" => "android", "application_id" => "com.example", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"id" => 1066175999, "application_id" => "com.example", "platform" => "android", "created_at" => "2022-04-05T12:53:44-04:00", "updated_at" => "2022-04-05T12:53:44-04:00", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false}}), headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.platform = "android"
    mobile_platform_application.application_id = "com.example"
    mobile_platform_application.sha256_cert_fingerprints = [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176000.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"id" => 1066176000, "application_id" => "X1Y2.ca.domain.app", "platform" => "ios", "created_at" => "2022-04-05T12:53:44-04:00", "updated_at" => "2022-04-05T12:53:44-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true}}), headers: {})

    ShopifyAPI::MobilePlatformApplication.find(
      id: 1066176000,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176000.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176001.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"application_id" => "A1B2.ca.domain.app", "platform" => "ios", "created_at" => "2022-04-05T12:53:45-04:00", "updated_at" => "2022-04-05T12:53:45-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"application_id" => "A1B2.ca.domain.app", "platform" => "ios", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true, "id" => 1066176001, "created_at" => "2022-04-05T12:53:45-04:00", "updated_at" => "2022-04-05T12:53:47-04:00"}}), headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.id = 1066176001
    mobile_platform_application.application_id = "A1B2.ca.domain.app"
    mobile_platform_application.platform = "ios"
    mobile_platform_application.created_at = "2022-04-05T12:53:45-04:00"
    mobile_platform_application.updated_at = "2022-04-05T12:53:45-04:00"
    mobile_platform_application.sha256_cert_fingerprints = []
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = true
    mobile_platform_application.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176001.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176002.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"application_id" => "com.example.news.app", "platform" => "android", "created_at" => "2022-04-05T12:53:47-04:00", "updated_at" => "2022-04-05T12:53:47-04:00", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"application_id" => "com.example.news.app", "platform" => "android", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false, "id" => 1066176002, "created_at" => "2022-04-05T12:53:47-04:00", "updated_at" => "2022-04-05T12:53:48-04:00"}}), headers: {})

    mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.id = 1066176002
    mobile_platform_application.application_id = "com.example.news.app"
    mobile_platform_application.platform = "android"
    mobile_platform_application.created_at = "2022-04-05T12:53:47-04:00"
    mobile_platform_application.updated_at = "2022-04-05T12:53:47-04:00"
    mobile_platform_application.sha256_cert_fingerprints = [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = false
    mobile_platform_application.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176002.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176003.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::MobilePlatformApplication.delete(
      id: 1066176003,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/mobile_platform_applications/1066176003.json")
  end

end
