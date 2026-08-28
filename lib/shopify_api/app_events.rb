# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AppEvents
    extend T::Sig

    # App Events is served by the Global API, which is versioned independently from the Admin API.
    EVENTS_PATH = "events"
    IDEMPOTENCY_CONFLICT_MAX_RETRIES = 2
    IDEMPOTENCY_CONFLICT_RETRY_WAIT_TIME = 1
    # The server sets `Idempotent-Replayed`; shopify.dev documents `Idempotent-Replay`.
    # Both carry the string `true`. HttpResponse#headers keys are downcased by Net::HTTPHeader#to_h.
    REPLAY_HEADERS = T.let(["idempotent-replayed", "idempotent-replay"], T::Array[String])

    class << self
      extend T::Sig

      sig do
        params(
          shop_id: T.any(String, Integer),
          event_handle: String,
          idempotency_key: String,
          attributes: T::Hash[T.any(String, Symbol), T.untyped],
          timestamp: T.nilable(Time),
        ).returns(LogResult)
      end
      def log(shop_id:, event_handle:, idempotency_key:, attributes:, timestamp: nil)
        unless ShopifyAPI::Context.setup?
          raise ShopifyAPI::Errors::ContextNotSetupError,
            "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
        end

        payload = EventPayload.build(
          shop_id: shop_id,
          event_handle: event_handle,
          idempotency_key: idempotency_key,
          attributes: attributes,
          timestamp: timestamp,
        )
        token = Auth::GlobalApiClientCredentials.global_api_client_credentials(force_refresh: false)
        response = begin
          post_event_with_retries(payload: payload, token: token)
        rescue ShopifyAPI::Errors::HttpResponseError => error
          raise unless error.code == 401

          replacement_token = Auth::GlobalApiClientCredentials.global_api_client_credentials(
            force_refresh: true,
            rejected_access_token: token.access_token,
          )
          begin
            post_event_with_retries(payload: payload, token: replacement_token)
          rescue ShopifyAPI::Errors::HttpResponseError => retry_error
            if retry_error.code == 401
              Auth::GlobalApiClientCredentials.clear_cached_token_if_matches!(
                access_token: replacement_token.access_token,
              )
            end
            raise
          end
        end

        LogResult.new(replayed: replayed?(response))
      end

      private

      sig do
        params(
          payload: T::Hash[Symbol, T.untyped],
          token: Auth::GlobalApiToken,
        ).returns(Clients::HttpResponse)
      end
      def post_event(payload:, token:)
        client = Clients::GlobalApiClient.new(
          base_path: "/app/#{Context.global_api_version}",
          access_token: token.access_token,
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

      sig do
        params(
          payload: T::Hash[Symbol, T.untyped],
          token: Auth::GlobalApiToken,
        ).returns(Clients::HttpResponse)
      end
      def post_event_with_retries(payload:, token:)
        retries = 0
        loop do
          return post_event(payload: payload, token: token)
        rescue ShopifyAPI::Errors::HttpResponseError => error
          raise unless error.code == 409 && retries < IDEMPOTENCY_CONFLICT_MAX_RETRIES

          retries += 1
          sleep(error.response.retry_request_after || IDEMPOTENCY_CONFLICT_RETRY_WAIT_TIME)
        end
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
