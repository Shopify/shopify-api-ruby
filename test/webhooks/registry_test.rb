# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"
require_relative "webhook_registration_queries.rb"

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
          "x-shopify-webhook-id" => "b1234-eefd-4c9e-9520-049845a02082",
          "x-shopify-api-version" => "2024-01",
        }

        @webhook_request = ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: @headers)
        @session = ShopifyAPI::Auth::Session.new(shop: ShopifyAPI::Context.host_name, access_token: "access_token")
        @url = "#{ShopifyAPI::Context.host}/admin/api/#{ShopifyAPI::Context.api_version}/graphql.json"
      end

      def test_add_http_registration_without_handler
        assert_raises(ShopifyAPI::Errors::InvalidWebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.add_registration(topic: @topic, path: "path", delivery_method: :http)
        end
      end

      def test_process
        handler_called = false

        handler = TestHelpers::FakeWebhookHandler.new(
          lambda do |topic, shop, body,|
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

      def test_process_with_response_as_struct
        modify_context(response_as_struct: true)

        handler_called = false

        handler = TestHelpers::FakeWebhookHandler.new(
          lambda do |topic, shop, body,|
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

      def test_process_new_handler
        handler_called = false

        handler = TestHelpers::NewFakeWebhookHandler.new(
          lambda do |data|
            assert_equal(@topic, data.topic)
            assert_equal(@shop, data.shop)
            assert_equal({}, data.body)
            assert_equal("b1234-eefd-4c9e-9520-049845a02082", data.webhook_id)
            assert_equal("2024-01", data.api_version)
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

      def test_http_registration_with_fields_array_add_and_update
        do_registration_test(:http, "test-webhooks", fields: ["field1", "field2"])
      end

      def test_http_registration_with_metafield_namespaces_add_and_update
        do_registration_test(:http, "test-webhooks", metafield_namespaces: ["namespace1", "namespace2"])
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

      def test_pubsub_registration_with_fields_array_add_and_update
        do_registration_test(:pub_sub, "pubsub://my-project-id:my-topic-id", fields: ["field1", "field2"])
      end

      def test_pubsub_registration_with_metafield_namespaces_add_and_update
        do_registration_test(:pub_sub, "pubsub://my-project-id:my-topic-id",
          metafield_namespaces: ["namespace1", "namespace2"])
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

      def test_eventbridge_registration_with_fields_array_add_and_update
        do_registration_test(:event_bridge, "test-webhooks", fields: ["field1", "field2"])
      end

      def test_eventbridge_registration_with_metafield_namespaces_add_and_update
        do_registration_test(:event_bridge, "test-webhooks", metafield_namespaces: ["namespace1", "namespace2"])
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

      def test_unregister_to_mandatory_topics_are_skipped
        ShopifyAPI::Clients::Graphql::Admin.expects(:new).never

        ShopifyAPI::Webhooks::Registry::MANDATORY_TOPICS.each do |topic|
          ShopifyAPI::Webhooks::Registry.unregister(
            topic: topic,
            session: @session,
          )
        end
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

      def test_get_webhook_id_success_for_event
        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[:fetch_id_event_query], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[:fetch_id_response]) })

        webhook_id_response = ShopifyAPI::Webhooks::Registry.get_webhook_id(
          topic: "domain.sub_domain.something_happened",
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

      def test_registrations_to_mandatory_topics_are_ignored
        ShopifyAPI::Webhooks::Registry.clear

        ShopifyAPI::Clients::Graphql::Admin.expects(:new).never

        ShopifyAPI::Webhooks::Registry::MANDATORY_TOPICS.each do |topic|
          ShopifyAPI::Webhooks::Registry.register(
            topic: topic,
            session: @session,
          )
        end
      end

      private

      def do_registration_test(delivery_method, path, fields: nil, metafield_namespaces: nil)
        ShopifyAPI::Webhooks::Registry.clear

        check_query_body = { query: queries[delivery_method][:check_query], variables: nil }

        stub_request(:post, @url)
          .with(body: JSON.dump(check_query_body))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][:check_empty_response]) })

        add_query_type = if fields
          :register_add_query_with_fields
        elsif metafield_namespaces
          :register_add_query_with_metafield_namespaces
        else
          :register_add_query
        end
        add_response_type = if fields
          :register_add_with_fields_response
        elsif metafield_namespaces
          :register_add_with_metafield_namespaces_response
        else
          :register_add_response
        end

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
          metafield_namespaces: metafield_namespaces,
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

      def do_registration_new_handler_test(delivery_method, path, fields: nil, metafield_namespaces: nil)
        ShopifyAPI::Webhooks::Registry.clear

        check_query_body = { query: queries[delivery_method][:check_query], variables: nil }

        stub_request(:post, @url)
          .with(body: JSON.dump(check_query_body))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][:check_empty_response]) })

        add_query_type = if fields
          :register_add_query_with_fields
        elsif metafield_namespaces
          :register_add_query_with_metafield_namespaces
        else
          :register_add_query
        end
        add_response_type = if fields
          :register_add_with_fields_response
        elsif metafield_namespaces
          :register_add_with_metafield_namespaces_response
        else
          :register_add_response
        end

        stub_request(:post, @url)
          .with(body: JSON.dump({ query: queries[delivery_method][add_query_type], variables: nil }))
          .to_return({ status: 200, body: JSON.dump(queries[delivery_method][add_response_type]) })

        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic,
          delivery_method: delivery_method,
          path: path,
          handler: TestHelpers::NewFakeWebhookHandler.new(
            lambda do |data|
            end,
          ),
          fields: fields,
          metafield_namespaces: metafield_namespaces,
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
          handler: TestHelpers::NewFakeWebhookHandler.new(
            lambda do |data|
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

      def do_registration_check_error_test_new_handler(delivery_method, path)
        ShopifyAPI::Webhooks::Registry.clear
        body = { query: queries[delivery_method][:check_query], variables: nil }

        stub_request(:post, @url)
          .with(body: JSON.dump(body))
          .to_return(status: 304)

        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic,
          delivery_method: delivery_method,
          path: path,
          handler: TestHelpers::NewFakeWebhookHandler.new(
            lambda do |data|
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
