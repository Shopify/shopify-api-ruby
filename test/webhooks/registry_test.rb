# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"

class RegistryTest < Test::Unit::TestCase
  def test_add_http_registration_with_handler
    ShopifyAPI::Webhooks::Registry.add_registration(topic: "some_topic", path: "path", delivery_method: :http,
      handler: TestHelpers::FakeWebhookHandler)
    assert_equal(TestHelpers::FakeWebhookHandler, ShopifyAPI::Webhooks::Registry.handler("some_topic"))
  end

  def test_add_http_registration_without_handler
    assert_raises(ShopifyAPI::Errors::InvalidWebhookRegistrationError) do
      ShopifyAPI::Webhooks::Registry.add_registration(topic: "some_topic", path: "path", delivery_method: :http)
    end
  end
end
