# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AppEvents
    extend T::Sig

    # App Events is served by the Global API, which is versioned independently from the Admin API.
    EVENTS_PATH = "events"
    # The server sets `Idempotent-Replayed`; shopify.dev documents `Idempotent-Replay`.
    # Both carry the string `true`. HttpResponse#headers keys are downcased by Net::HTTPHeader#to_h.
    REPLAY_HEADERS = T.let(["idempotent-replayed", "idempotent-replay"], T::Array[String])

    class << self
      extend T::Sig

      sig do
        params(
          myshopify_domain: String,
          event_handle: String,
          idempotency_key: String,
          attributes: T::Hash[T.any(String, Symbol), T.untyped],
          access_token: String,
          timestamp: T.nilable(Time),
        ).returns(LogResult)
      end
      def log(myshopify_domain:, event_handle:, idempotency_key:, attributes:, access_token:, timestamp: nil)
        unless ShopifyAPI::Context.setup?
          raise ShopifyAPI::Errors::ContextNotSetupError,
            "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
        end

        if access_token.strip.empty?
          raise ShopifyAPI::Errors::MissingRequiredArgumentError, "access_token argument is required"
        end

        payload = EventPayload.build(
          myshopify_domain: myshopify_domain,
          event_handle: event_handle,
          idempotency_key: idempotency_key,
          attributes: attributes,
          timestamp: timestamp,
        )
        response = post_event(payload: payload, access_token: access_token)

        LogResult.new(replayed: replayed?(response))
      end

      private

      sig do
        params(
          payload: T::Hash[Symbol, T.untyped],
          access_token: String,
        ).returns(Clients::HttpResponse)
      end
      def post_event(payload:, access_token:)
        client = Clients::GlobalApiClient.new(
          base_path: "/app/#{Context.global_api_version}",
          access_token: access_token,
        )
        client.request(
          Clients::HttpRequest.new(
            http_method: :post,
            path: EVENTS_PATH,
            body: payload,
            body_type: "application/json",
          ),
        )
      end

      sig { params(response: Clients::HttpResponse).returns(T::Boolean) }
      def replayed?(response)
        REPLAY_HEADERS.any? do |name|
          response.headers[name]&.any? { |value| value.strip.casecmp?("true") }
        end
      end
    end
  end
end
