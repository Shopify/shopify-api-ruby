# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"
require_relative "./webhook_registration_queries.rb"

module ShopifyAPITest
  module Webhooks
    class RegistryTest < Test::Unit::TestCase
      include RegistryTestQueries
      def setup
        super
        @topic = "some/topic"
        @shop = "shop.myshopify.com"

        hmac = OpenSSL::HMAC.digest(
          OpenSSL::Digest.new("sha256"),
          ShopifyAPI::Context.api_secret_key,
          "{}",
        )

        @headers = {
          "x-shopify-topic" => @topic,
          "x-shopify-hmac-sha256" => Base64.encode64(hmac),
          "x-shopify-shop-domain" => @shop,
        }

        @webhook_request = ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: @headers)
        @session = ShopifyAPI::Auth::Session.new(shop: ShopifyAPI::Context.host_name, access_token: "access_token")
        @url = "https://#{ShopifyAPI::Context.host_name}/admin/api/#{ShopifyAPI::Context.api_version}/graphql.json"
      end

      def test_add_http_registration_without_handler
        assert_raises(ShopifyAPI::Errors::InvalidWebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.add_registration(topic: @topic, path: "path", delivery_method: :http)
        end
      end

      def test_process
        handler_called = false

        handler = TestHelpers::FakeWebhookHandler.new(
          lambda do |topic, shop, body|
            assert_equal(@topic, topic)
            assert_equal(@shop, shop)
            assert_equal({}, body)
            handler_called = true
          end,
        )

        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic, path: "path", delivery_method: :http, handler: handler,
        )

        ShopifyAPI::Webhooks::Registry.process(@webhook_request)

        assert(handler_called)
      end

      def test_process_hmac_validation_fails
        headers = {
          "x-shopify-topic" => "some/topic",
          "x-shopify-hmac-sha256" => "invalid",
          "x-shopify-shop-domain" => "shop.myshopify.com",
        }

        assert_raises(ShopifyAPI::Errors::InvalidWebhookError) do
          ShopifyAPI::Webhooks::Registry.process(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers))
        end
      end

      def test_process_no_handler
        @headers["x-shopify-topic"] = "non_registered_topic"

        assert_raises(ShopifyAPI::Errors::NoWebhookHandler) do
          ShopifyAPI::Webhooks::Registry.process(ShopifyAPI::Webhooks::Request.new(raw_body: "{}",
            headers: @headers))
        end
      end

      def test_http_registration_add_and_update
        do_registration_test(:http, "test-webhooks")
      end

      def test_http_registration_add_and_update_with_full_url
        do_registration_test(:http, "https://app-address.com/test-webhooks")
      end

      def test_http_registration_add_and_update_with_schemeless_url
        do_registration_test(:http, "app-address.com/test-webhooks")
      end

      def test_http_registration_with_fields_add_and_update
        do_registration_test(:http, "test-webhooks", fields: "field1, field2")
      end

      def test_raises_on_http_registration_check_error
        do_registration_check_error_test(:http, "test-webhooks")
      end

      def test_pubsub_registration_add_and_update
        do_registration_test(:pub_sub, "pubsub://my-project-id:my-topic-id")
      end

      def test_pubsub_registration_with_fields_add_and_update
        do_registration_test(:pub_sub, "pubsub://my-project-id:my-topic-id", fields: "field1, field2")
      end

      def test_raises_on_pubsub_registration_check_error
        do_registration_check_error_test(:pub_sub, "pubsub://my-project-id:my-topic-id")
      end

      def test_eventbridge_registration_add_and_update
        do_registration_test(:event_bridge, "test-webhooks")
      end

      def test_eventbridge_registration_with_fields_add_and_update
        do_registration_test(:event_bridge, "test-webhooks", fields: "field1, field2")
      end

      def test_raises_on_eventbridge_registration_check_error
        do_registration_check_error_test(:event_bridge, "test-webhooks")
      end

      def test_register_topic_not_not_registry
        assert_raises(ShopifyAPI::Errors::InvalidWebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.register(topic: "not-registered", session: @session)
        end
      end

      def test_unregister_success
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response]) })

        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:delete_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:delete_response]) })

        delete_response = ShopifyAPI::Webhooks::Registry.unregister(
          topic: "some/topic",
          session: @session,
        )

        assert_equal(queries[:delete_response], delete_response)
      end

      def test_unregister_fail_with_errors
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response]) })

        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:delete_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:delete_response_with_errors]) })

        exception = assert_raises(ShopifyAPI::Errors::WebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.unregister(
            topic: "some/topic",
            session: @session,
          )
        end
        assert_equal("Failed to delete webhook from Shopify: some error", exception.message)
      end

      def test_unregister_fail_with_user_errors
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response]) })

        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:delete_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:delete_response_with_user_errors]) })

        exception = assert_raises(ShopifyAPI::Errors::WebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.unregister(
            topic: "some/topic",
            session: @session,
          )
        end
        assert_equal("Failed to delete webhook from Shopify: some error", exception.message)
      end

      def test_get_webhook_id_success
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response]) })

        webhook_id_response = ShopifyAPI::Webhooks::Registry.get_webhook_id(
          topic: "some/topic",
          client: ShopifyAPI::Clients::Graphql::Admin.new(session: @session),
        )
        assert_equal(
          queries[:fetch_id_response]["data"]["webhookSubscriptions"]["edges"][0]["node"]["id"],
          webhook_id_response,
        )
      end

      def test_get_webhook_id_not_found
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response_not_found]) })

        webhook_id_response = ShopifyAPI::Webhooks::Registry.get_webhook_id(
          topic: "some/topic",
          client: ShopifyAPI::Clients::Graphql::Admin.new(session: @session),
        )
        assert_nil(webhook_id_response)
      end

      def test_get_webhook_id_with_graphql_errors
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response_with_errors]) })

        exception = assert_raises(ShopifyAPI::Errors::WebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.get_webhook_id(
            topic: "some/topic",
            client: ShopifyAPI::Clients::Graphql::Admin.new(session: @session),
          )
        end
        assert_equal("Failed to fetch webhook from Shopify: some error", exception.message)
      end

      private

      def do_registration_test(delivery_method, path, fields: nil)
        ShopifyAPI::Webhooks::Registry.clear

        check_query_body = { query: queries[delivery_method][:check_query], variables: nil }

        stub_request(:post, @url)
          .with(body: JSON.dump(check_query_body))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][:check_empty_response]) })

        add_query_type = fields.nil? ? :register_add_query : :register_add_query_with_fields
        add_response_type = fields.nil? ? :register_add_response : :register_add_with_fields_response
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[delivery_method][add_query_type], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][add_response_type]) })

        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic,
          delivery_method: delivery_method,
          path: path,
          handler: TestHelpers::FakeWebhookHandler.new(
            lambda do |topic, shop, body|
            end,
          ),
          fields: fields,
        )
        registration_response = ShopifyAPI::Webhooks::Registry.register_all(
          session: @session,
        )[0]

        assert(registration_response.success)
        assert_equal(queries[delivery_method][add_response_type], registration_response.body)

        stub_request(:post, @url)
          .with(body: JSON.dump(check_query_body))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][:check_existing_response]) })

        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[delivery_method][:register_update_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][:register_update_response]) })

        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic,
          delivery_method: delivery_method,
          path: "#{path}-updated",
          handler: TestHelpers::FakeWebhookHandler.new(
            lambda do |topic, shop, body|
            end,
          ),
        )
        update_registration_response = ShopifyAPI::Webhooks::Registry.register_all(
          session: @session,
        )[0]

        assert(update_registration_response.success)
        assert_equal(queries[delivery_method][:register_update_response], update_registration_response.body)
      end

      def do_registration_check_error_test(delivery_method, path)
        ShopifyAPI::Webhooks::Registry.clear
        body = { query: queries[delivery_method][:check_query], variables: nil }

        stub_request(:post, @url)
          .with(body: JSON.dump(body))
          .to_return(status: 304)

        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic,
          delivery_method: delivery_method,
          path: path,
          handler: TestHelpers::FakeWebhookHandler.new(
            lambda do |topic, shop, body|
            end,
          ),
        )

        assert_raises(StandardError) do
          ShopifyAPI::Webhooks::Registry.register_all(
          session: @session,
        )
        end
      end
    end
  end
end
