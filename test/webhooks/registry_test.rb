# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"
require_relative "registry_test_queries.rb"

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

      VALID_PROTOCOL_ADDRESSES = {
        http: ["test-webhooks", "https://app-address.com/test-webhooks", "app-address.com/test-webhooks"],
        pub_sub: ["pubsub://my-project-id:my-topic-id"],
        event_bridge: ["test-webhooks"],
      }

      VALID_PROTOCOL_ADDRESSES.each do |protocol, addresses|
        addresses.each do |address|
          define_method("test_#{protocol}_no_registration_if_identical_webhook_exists_with_address_#{address}") do
            # Given
            setup_queries_and_responses(
              [queries[protocol][:check_query]],
              [queries[protocol][:check_existing_response_with_attributes]],
            )

            # When
            update_registration_response = add_and_register_webhook(
              protocol,
              address,
              fields: "field1, field2",
              metafield_namespaces: ["namespace1", "namespace2"],
            )

            # Then
            assert_nil(update_registration_response.body)
          end

          define_method("test_#{protocol}_add_registration_with_address_#{address}") do
            # Given
            setup_queries_and_responses(
              [queries[protocol][:check_query], queries[protocol][:register_add_query]],
              [queries[protocol][:check_empty_response], queries[protocol][:register_add_response]],
            )

            # When
            update_registration_response = add_and_register_webhook(
              protocol,
              address,
              fields: ["field1", "field2"],
              metafield_namespaces: ["namespace1", "namespace2"],
            )

            # Then
            assert(update_registration_response.success)
            assert_equal(queries[protocol][:register_add_response], update_registration_response.body)
          end

          define_method("test_#{protocol}_update_registration_address_with_original_address_#{address}") do
            # Given
            setup_queries_and_responses(
              [queries[protocol][:check_query], queries[protocol][:register_update_query]],
              [queries[protocol][:check_existing_response], queries[protocol][:register_update_response]],
            )

            # When
            update_registration_response = add_and_register_webhook(
              protocol,
              address + "-updated",
            )

            # Then
            assert(update_registration_response.success)
            assert_equal(queries[protocol][:register_update_response], update_registration_response.body)
          end

          define_method("test_#{protocol}_update_registration_fields_with_address_#{address}") do
            # Given
            setup_queries_and_responses(
              [queries[protocol][:check_query], queries[protocol][:register_update_query_with_fields]],
              [queries[protocol][:check_existing_response], queries[protocol][:register_update_with_fields_response]],
            )

            # When
            update_registration_response = add_and_register_webhook(
              protocol,
              address,
              fields: "field1, field2, field3",
            )

            # Then
            assert(update_registration_response.success)
            assert_equal(queries[protocol][:register_update_with_fields_response], update_registration_response.body)
          end

          define_method("test_#{protocol}_update_registration_fields_array_with_address_#{address}") do
            # Given
            setup_queries_and_responses(
              [queries[protocol][:check_query], queries[protocol][:register_update_query_with_fields]],
              [queries[protocol][:check_existing_response], queries[protocol][:register_update_with_fields_response]],
            )

            # When
            update_registration_response = add_and_register_webhook(
              protocol,
              address,
              fields: ["field1", "field2", "field3"],
            )

            # Then
            assert(update_registration_response.success)
            assert_equal(queries[protocol][:register_update_with_fields_response], update_registration_response.body)
          end

          define_method("test_#{protocol}_update_registration_metafield_namespaces_with_address_#{address}") do
            # Given
            setup_queries_and_responses(
              [queries[protocol][:check_query], queries[protocol][:register_update_query_with_metafield_namespaces]],
              [queries[protocol][:check_existing_response],
               queries[protocol][:register_update_with_metafield_namespaces_response],],
            )

            # When
            update_registration_response = add_and_register_webhook(
              protocol,
              address,
              metafield_namespaces: ["namespace1", "namespace2", "namespace3"],
            )

            # Then
            assert(update_registration_response.success)
            assert_equal(queries[protocol][:register_update_with_metafield_namespaces_response],
              update_registration_response.body)
          end

          define_method("test_raises_on_#{protocol}_registration_check_error_with_address_#{address}") do
            # Given
            ShopifyAPI::Webhooks::Registry.clear
            body = { query: queries[protocol][:check_query], variables: nil }

            stub_request(:post, @url)
              .with(body: JSON.dump(body))
              .to_return(status: 304)

            # When
            ShopifyAPI::Webhooks::Registry.add_registration(
              topic: @topic,
              delivery_method: protocol,
              path: address,
              handler: TestHelpers::FakeWebhookHandler.new(
                lambda do |topic, shop, body|
                end,
              ),
            )

            # Then
            assert_raises(StandardError) do
              ShopifyAPI::Webhooks::Registry.register_all(
              session: @session,
            )
            end
          end
        end
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
          ShopifyAPI::Webhooks::Registry.process(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: @headers))
        end
      end

      def test_register_topic_not_not_registry
        assert_raises(ShopifyAPI::Errors::InvalidWebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.register(topic: "not-registered", session: @session)
        end
      end

      def test_unregister_success
        setup_queries_and_responses(
          [queries[:fetch_id_query], queries[:delete_query]],
          [queries[:fetch_id_response], queries[:delete_response]],
        )

        delete_response = ShopifyAPI::Webhooks::Registry.unregister(
          topic: "some/topic",
          session: @session,
        )

        assert_equal(queries[:delete_response], delete_response)
      end

      def test_unregister_fail_with_errors
        setup_queries_and_responses(
          [queries[:fetch_id_query], queries[:delete_query]],
          [queries[:fetch_id_response], queries[:delete_response_with_errors]],
        )

        exception = assert_raises(ShopifyAPI::Errors::WebhookRegistrationError) do
          ShopifyAPI::Webhooks::Registry.unregister(
            topic: "some/topic",
            session: @session,
          )
        end
        assert_equal("Failed to delete webhook from Shopify: some error", exception.message)
      end

      def test_unregister_fail_with_user_errors
        setup_queries_and_responses(
          [queries[:fetch_id_query], queries[:delete_query]],
          [queries[:fetch_id_response], queries[:delete_response_with_user_errors]],
        )

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
        setup_queries_and_responses([queries[:fetch_id_query]], [queries[:fetch_id_response]])

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
        setup_queries_and_responses([queries[:fetch_id_event_query]], [queries[:fetch_id_response]])

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
        setup_queries_and_responses([queries[:fetch_id_query]], [queries[:fetch_id_response_not_found]])

        webhook_id_response = ShopifyAPI::Webhooks::Registry.get_webhook_id(
          topic: "some/topic",
          client: ShopifyAPI::Clients::Graphql::Admin.new(session: @session),
        )
        assert_nil(webhook_id_response)
      end

      def test_get_webhook_id_with_graphql_errors
        setup_queries_and_responses([queries[:fetch_id_query]], [queries[:fetch_id_response_with_errors]])

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

      def setup_queries_and_responses(queries, responses)
        ShopifyAPI::Webhooks::Registry.clear
        queries.zip(responses).each do |query, response|
          stub_request(:post, @url)
            .with(body: JSON.dump({ query: query, variables: nil }))
            .to_return({ status: 200, body: JSON.dump(response) })
        end
      end

      def add_and_register_webhook(protocol, address, fields: nil, metafield_namespaces: nil)
        ShopifyAPI::Webhooks::Registry.add_registration(
          topic: @topic,
          delivery_method: protocol,
          path: address,
          handler: TestHelpers::FakeWebhookHandler.new(
            lambda do |topic, shop, body|
            end,
          ),
          fields: fields,
          metafield_namespaces: metafield_namespaces,
        )
        update_registration_response = ShopifyAPI::Webhooks::Registry.register_all(
          session: @session,
        )[0]

        update_registration_response
      end
    end
  end
end
