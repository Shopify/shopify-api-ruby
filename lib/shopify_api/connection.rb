# frozen_string_literal: true
module ShopifyAPI
  class Connection < ActiveResource::Connection
    attr_reader :response

    module ResponseCapture
      def handle_response(response)
        @response = super(ShopifyAPI::MessageEnricher.new(response))
      end
    end

    include ResponseCapture

    module RequestNotification
      def request(method, path, *arguments)
        super.tap do |response|
          notify_about_request(method, path, response, arguments)
        end
      rescue => e
        notify_about_request(method, path, e.response, arguments) if e.respond_to?(:response)
        raise
      end

      def notify_about_request(method, path, response, arguments)
        ActiveSupport::Notifications.instrument("request.active_resource_detailed") do |payload|
          payload[:method]   = method
          payload[:path]     = path
          payload[:response] = response
          payload[:data]     = arguments
        end
      end
    end

    include RequestNotification
  end
end
