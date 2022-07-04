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

class ApplePayCertificate202207Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "apple_pay_certificate" => hash_including({}) }
      )
      .to_return(status: 200, body: JSON.generate({"apple_pay_certificate" => {"id" => 1068938274, "status" => "issuing", "merchant_id" => nil}}), headers: {})

    apple_pay_certificate = ShopifyAPI::ApplePayCertificate.new

    apple_pay_certificate.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938275.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"apple_pay_certificate" => {"id" => 1068938275, "status" => "csr", "merchant_id" => nil}}), headers: {})

    ShopifyAPI::ApplePayCertificate.find(
      id: 1068938275,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938275.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938277.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "apple_pay_certificate" => hash_including({"status" => "completed", "merchant_id" => "merchant.something", "encoded_signed_certificate" => "MIIEZzCCBA6gAwIBAgIIWGMideLkDJAwCgYIKoZIzj0EAwIwgYAxNDAyBgNV\nBAMMK0FwcGxlIFdvcmxkd2lkZSBEZXZlbG9wZXIgUmVsYXRpb25zIENBIC0g\nRzIxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMw\nEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzAeFw0xNDEyMDgyMTMy\nMDBaFw0xNzAxMDYyMTMyMDBaMIGZMSowKAYKCZImiZPyLGQBAQwabWVyY2hh\nbnQuY29tLm5vcm1vcmUuamFzb24xMDAuBgNVBAMMJ01lcmNoYW50IElEOiBt\nZXJjaGFudC5jb20ubm9ybW9yZS5qYXNvbjETMBEGA1UECwwKNVVZMzJOTE5O\nOTEXMBUGA1UECgwOSm9zaHVhIFRlc3NpZXIxCzAJBgNVBAYTAkNBMFkwEwYH\nKoZIzj0CAQYIKoZIzj0DAQcDQgAEAxDDCvzG6MnsZSJOtbr0hr3MRq+4HzTZ\nx8J4FD34E3kU5CallEnZLBmnzfqmjP8644SO28LLJxvWBnrg7lHFtaOCAlUw\nggJRMEcGCCsGAQUFBwEBBDswOTA3BggrBgEFBQcwAYYraHR0cDovL29jc3Au\nYXBwbGUuY29tL29jc3AwNC1hcHBsZXd3ZHJjYTIwMTAdBgNVHQ4EFgQUkPsO\nKEKvhL/takKomy5GWXtCd8wwDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBSE\ntoTMOoZichZZlOgao71I3zrfCzCCAR0GA1UdIASCARQwggEQMIIBDAYJKoZI\nhvdjZAUBMIH+MIHDBggrBgEFBQcCAjCBtgyBs1JlbGlhbmNlIG9uIHRoaXMg\nY2VydGlmaWNhdGUgYnkgYW55IHBhcnR5IGFzc3VtZXMgYWNjZXB0YW5jZSBv\nZiB0aGUgdGhlbiBhcHBsaWNhYmxlIHN0YW5kYXJkIHRlcm1zIGFuZCBjb25k\naXRpb25zIG9mIHVzZSwgY2VydGlmaWNhdGUgcG9saWN5IGFuZCBjZXJ0aWZp\nY2F0aW9uIHByYWN0aWNlIHN0YXRlbWVudHMuMDYGCCsGAQUFBwIBFipodHRw\nOi8vd3d3LmFwcGxlLmNvbS9jZXJ0aWZpY2F0ZWF1dGhvcml0eS8wNgYDVR0f\nBC8wLTAroCmgJ4YlaHR0cDovL2NybC5hcHBsZS5jb20vYXBwbGV3d2RyY2Ey\nLmNybDAOBgNVHQ8BAf8EBAMCAygwTwYJKoZIhvdjZAYgBEIMQDM0NTBBMjhB\nOTlGRjIyRkI5OTdDRERFODU1REREOTI5NTE4RjVGMDdBQUM4NzdDMzRCQjM3\nODFCQTg2MzkyNjIwCgYIKoZIzj0EAwIDRwAwRAIgZ/oNx0gCc/PM4pYhOWL2\nCecFQrIgzHr/fZd8qcy3Be8CIEQCaAPpmvQrXEX0hFexoYMHtOHY9dgN2D8L\nNKpVyn3t\n"}) }
      )
      .to_return(status: 200, body: JSON.generate({"apple_pay_certificate" => {"id" => 1068938277, "status" => "completed", "merchant_id" => "merchant.something"}}), headers: {})

    apple_pay_certificate = ShopifyAPI::ApplePayCertificate.new
    apple_pay_certificate.id = 1068938277
    apple_pay_certificate.status = "completed"
    apple_pay_certificate.merchant_id = "merchant.something"
    apple_pay_certificate.encoded_signed_certificate = "MIIEZzCCBA6gAwIBAgIIWGMideLkDJAwCgYIKoZIzj0EAwIwgYAxNDAyBgNV\nBAMMK0FwcGxlIFdvcmxkd2lkZSBEZXZlbG9wZXIgUmVsYXRpb25zIENBIC0g\nRzIxJjAkBgNVBAsMHUFwcGxlIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMw\nEQYDVQQKDApBcHBsZSBJbmMuMQswCQYDVQQGEwJVUzAeFw0xNDEyMDgyMTMy\nMDBaFw0xNzAxMDYyMTMyMDBaMIGZMSowKAYKCZImiZPyLGQBAQwabWVyY2hh\nbnQuY29tLm5vcm1vcmUuamFzb24xMDAuBgNVBAMMJ01lcmNoYW50IElEOiBt\nZXJjaGFudC5jb20ubm9ybW9yZS5qYXNvbjETMBEGA1UECwwKNVVZMzJOTE5O\nOTEXMBUGA1UECgwOSm9zaHVhIFRlc3NpZXIxCzAJBgNVBAYTAkNBMFkwEwYH\nKoZIzj0CAQYIKoZIzj0DAQcDQgAEAxDDCvzG6MnsZSJOtbr0hr3MRq+4HzTZ\nx8J4FD34E3kU5CallEnZLBmnzfqmjP8644SO28LLJxvWBnrg7lHFtaOCAlUw\nggJRMEcGCCsGAQUFBwEBBDswOTA3BggrBgEFBQcwAYYraHR0cDovL29jc3Au\nYXBwbGUuY29tL29jc3AwNC1hcHBsZXd3ZHJjYTIwMTAdBgNVHQ4EFgQUkPsO\nKEKvhL/takKomy5GWXtCd8wwDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBSE\ntoTMOoZichZZlOgao71I3zrfCzCCAR0GA1UdIASCARQwggEQMIIBDAYJKoZI\nhvdjZAUBMIH+MIHDBggrBgEFBQcCAjCBtgyBs1JlbGlhbmNlIG9uIHRoaXMg\nY2VydGlmaWNhdGUgYnkgYW55IHBhcnR5IGFzc3VtZXMgYWNjZXB0YW5jZSBv\nZiB0aGUgdGhlbiBhcHBsaWNhYmxlIHN0YW5kYXJkIHRlcm1zIGFuZCBjb25k\naXRpb25zIG9mIHVzZSwgY2VydGlmaWNhdGUgcG9saWN5IGFuZCBjZXJ0aWZp\nY2F0aW9uIHByYWN0aWNlIHN0YXRlbWVudHMuMDYGCCsGAQUFBwIBFipodHRw\nOi8vd3d3LmFwcGxlLmNvbS9jZXJ0aWZpY2F0ZWF1dGhvcml0eS8wNgYDVR0f\nBC8wLTAroCmgJ4YlaHR0cDovL2NybC5hcHBsZS5jb20vYXBwbGV3d2RyY2Ey\nLmNybDAOBgNVHQ8BAf8EBAMCAygwTwYJKoZIhvdjZAYgBEIMQDM0NTBBMjhB\nOTlGRjIyRkI5OTdDRERFODU1REREOTI5NTE4RjVGMDdBQUM4NzdDMzRCQjM3\nODFCQTg2MzkyNjIwCgYIKoZIzj0EAwIDRwAwRAIgZ/oNx0gCc/PM4pYhOWL2\nCecFQrIgzHr/fZd8qcy3Be8CIEQCaAPpmvQrXEX0hFexoYMHtOHY9dgN2D8L\nNKpVyn3t\n"
    apple_pay_certificate.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938277.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938278.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::ApplePayCertificate.delete(
      id: 1068938278,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938278.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938276/csr.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"csr" => {"key" => "YXBwbGUtcGF5LWNzcg==\n"}}), headers: {})

    ShopifyAPI::ApplePayCertificate.csr(
      id: 1068938276,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/apple_pay_certificates/1068938276/csr.json")
  end

end
