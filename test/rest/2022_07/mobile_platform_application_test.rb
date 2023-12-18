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

class MobilePlatformApplication202207Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_applications" => [{"id" => 1066175996, "application_id" => "X1Y2.ca.domain.app", "platform" => "ios", "created_at" => "2023-07-11T18:15:32-04:00", "updated_at" => "2023-07-11T18:15:32-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true, "enabled_app_clips" => false, "app_clip_application_id" => nil}, {"id" => 1066175997, "application_id" => "com.example", "platform" => "android", "created_at" => "2023-07-11T18:15:32-04:00", "updated_at" => "2023-07-11T18:15:32-04:00", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false, "enabled_app_clips" => false, "app_clip_application_id" => nil}]}), headers: {})

    response = ShopifyAPI::MobilePlatformApplication.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"platform" => "android", "application_id" => "com.example", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"id" => 1066176003, "application_id" => "com.example", "platform" => "android", "created_at" => "2023-07-11T18:15:43-04:00", "updated_at" => "2023-07-11T18:15:43-04:00", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false, "enabled_app_clips" => false, "app_clip_application_id" => nil}}), headers: {})

    response = mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.platform = "android"
    mobile_platform_application.application_id = "com.example"
    mobile_platform_application.sha256_cert_fingerprints = [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"platform" => "ios", "application_id" => "X1Y2.ca.domain.app", "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"id" => 1066176001, "application_id" => "X1Y2.ca.domain.app", "platform" => "ios", "created_at" => "2023-07-11T18:15:40-04:00", "updated_at" => "2023-07-11T18:15:40-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true, "enabled_app_clips" => false, "app_clip_application_id" => nil}}), headers: {})

    response = mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.platform = "ios"
    mobile_platform_application.application_id = "X1Y2.ca.domain.app"
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = true
    mobile_platform_application.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066175998.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"id" => 1066175998, "application_id" => "X1Y2.ca.domain.app", "platform" => "ios", "created_at" => "2023-07-11T18:15:33-04:00", "updated_at" => "2023-07-11T18:15:33-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true, "enabled_app_clips" => false, "app_clip_application_id" => nil}}), headers: {})

    response = ShopifyAPI::MobilePlatformApplication.find(
      id: 1066175998,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066175998.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066176002.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"application_id" => "com.example.news.app", "platform" => "android", "created_at" => "2023-07-11T18:15:40-04:00", "updated_at" => "2023-07-11T18:15:40-04:00", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false, "enabled_app_clips" => false, "app_clip_application_id" => nil}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"application_id" => "com.example.news.app", "platform" => "android", "sha256_cert_fingerprints" => ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => false, "id" => 1066176002, "created_at" => "2023-07-11T18:15:40-04:00", "updated_at" => "2023-07-11T18:15:42-04:00", "enabled_app_clips" => false, "app_clip_application_id" => nil}}), headers: {})

    response = mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.id = 1066176002
    mobile_platform_application.application_id = "com.example.news.app"
    mobile_platform_application.platform = "android"
    mobile_platform_application.created_at = "2023-07-11T18:15:40-04:00"
    mobile_platform_application.updated_at = "2023-07-11T18:15:40-04:00"
    mobile_platform_application.sha256_cert_fingerprints = [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = false
    mobile_platform_application.enabled_app_clips = false
    mobile_platform_application.app_clip_application_id = nil
    mobile_platform_application.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066176002.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_6()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066176000.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "mobile_platform_application" => hash_including({"application_id" => "A1B2.ca.domain.app", "platform" => "ios", "created_at" => "2023-07-11T18:15:37-04:00", "updated_at" => "2023-07-11T18:15:37-04:00", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true, "enabled_app_clips" => false, "app_clip_application_id" => nil}) }
      )
      .to_return(status: 200, body: JSON.generate({"mobile_platform_application" => {"application_id" => "A1B2.ca.domain.app", "platform" => "ios", "sha256_cert_fingerprints" => [], "enabled_universal_or_app_links" => true, "enabled_shared_webcredentials" => true, "id" => 1066176000, "created_at" => "2023-07-11T18:15:37-04:00", "updated_at" => "2023-07-11T18:15:39-04:00", "enabled_app_clips" => false, "app_clip_application_id" => nil}}), headers: {})

    response = mobile_platform_application = ShopifyAPI::MobilePlatformApplication.new
    mobile_platform_application.id = 1066176000
    mobile_platform_application.application_id = "A1B2.ca.domain.app"
    mobile_platform_application.platform = "ios"
    mobile_platform_application.created_at = "2023-07-11T18:15:37-04:00"
    mobile_platform_application.updated_at = "2023-07-11T18:15:37-04:00"
    mobile_platform_application.sha256_cert_fingerprints = []
    mobile_platform_application.enabled_universal_or_app_links = true
    mobile_platform_application.enabled_shared_webcredentials = true
    mobile_platform_application.enabled_app_clips = false
    mobile_platform_application.app_clip_application_id = nil
    mobile_platform_application.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066176000.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_7()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066175999.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::MobilePlatformApplication.delete(
      id: 1066175999,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/mobile_platform_applications/1066175999.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

end
