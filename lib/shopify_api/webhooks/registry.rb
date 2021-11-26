# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    class Registry
      @registry = T.let({}, T::Hash[String, Registration])

      class << self
        extend T::Sig
        sig { params(topic: String, delivery_method: Symbol, path: String, handler: T.nilable(Handler)).void }
        def add_registration(topic:, delivery_method:, path:, handler: nil)
          @registry[topic] = case delivery_method
          when :pub_sub
            Registrations::PubSub.new(topic: topic, path: path)
          when :event_bridge
            Registrations::EventBridge.new(topic: topic, path: path)
          when :http
            unless handler
              raise Errors::InvalidWebhookRegistrationError, "Cannot create an Http registration without a handler."
            end
            Registrations::Http.new(topic: topic, path: path, handler: handler)
          else
            raise Errors::InvalidWebhookRegistrationError, "Unsupported delivery method #{delivery_method}."
          end
        end

        sig { void }
        def register_all
          # TODO: make registration calls using graphQL client
        end

        sig { params(request: Request).void }
        def process(request)
          raise Errors::InvalidWebhookError, "Invalid webhook HMAC." unless Utils::HmacValidator.validate(request)

          handler = @registry[request.topic]&.handler

          unless handler
            raise Errors::NoWebhookHandler, "No webhook handler found for topic: #{request.topic}."
          end

          handler.handle(topic: request.topic, shop: request.shop, body: request.parsed_body)
        end
      end
    end
  end
end
