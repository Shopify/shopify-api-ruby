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

        sig { params(topic: String).returns(T.nilable(Handler)) }
        def handler(topic)
          @registry[topic].nil? ? nil : T.must(@registry[topic]).handler
        end

        sig { void }
        def register_all
          # TODO: make registration calls using graphQL client
        end
      end
    end
  end
end
