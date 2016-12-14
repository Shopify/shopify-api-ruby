require "test_helper"

class DummyAsyncResource < ShopifyAPI::Base
  def self.element_url(id, *args)
    "#{site}#{element_path(id, *args)}"
  end
end

module ShopifyAPI
  class AsyncResourceTest < Test::Unit::TestCase
    def test_retry_poll
      FakeWeb.register_uri(
        :get,
        "https://this-is-my-test-shop.myshopify.com/admin/dummy_async_resources/mock_a.json",
        [
          { body: {}.to_json, status: 202 }
          { body: {}.to_json, status: 200 }
        ]
      )

      ShopifyAPI::AsyncResource.poll(:retry, DummyAsyncResource.connection, tests_defaults) do
        DummyAsyncResource.find("mock_a")
      end
    end

    def test_follow_location_poll
      fake "dummy_async_resources/mock_a", method: :get, status: 202, body: {}.to_json
        headers: { "Location" => DummyAsyncResource.element_url("mock_b") }
      fake "dummy_async_resources/mock_b", method: :get, status: 202, body: {}.to_json
        headers: { "Location" => DummyAsyncResource.element_url("mock_c") }
      fake "dummy_async_resources/mock_c", method: :get, status: 200, body: { "alain" => "proviste" }.to_json

      ShopifyAPI::AsyncResource.poll(:follow_location, DummyAsyncResource.connection, tests_defaults) do
        DummyAsyncResource.find("mock_a")
      end
    end

    private

    def tests_defaults
      {
        max_retries: 5,
        interva: 1,
        waiting_strategy: -> (*) { },
      }
    end
  end
end
