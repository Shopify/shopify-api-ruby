module ShopifyAPI
  class Connection
    attr_reader :response

    def handle_response(response)
      @response = super
    end

    def request(method, path, *arguments)
      super.tap do |response|
        notify_about_request(response, arguments)
      end
    rescue => e
      notify_about_request(e.response, arguments) if e.respond_to?(:response)
      raise
    end

    def notify_about_request(response, arguments)
      ActiveSupport::Notifications.instrument("request.active_resource_detailed") do |payload|
        payload[:response] = response
        payload[:data]     = arguments
      end
    end
  end
end
