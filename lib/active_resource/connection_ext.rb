require 'active_support/core_ext/module/aliasing'

module ActiveResource
  class Connection

    attr_reader :response

    def handle_response_with_response_capture(response)
      @response = handle_response_without_response_capture(response)
    end

    def request_with_detailed_log_subscriber(method, path, *arguments)
      result = request_without_detailed_log_subscriber(method, path, *arguments)
      detailed_log_subscriber(result, arguments)
      result
    rescue => e
      detailed_log_subscriber(e.response, arguments) if e.respond_to?(:response)
      raise
    end

    def detailed_log_subscriber(response, arguments)
      ActiveSupport::Notifications.instrument("request.active_resource_detailed") do |payload|
        payload[:response] = response
        payload[:data]     = arguments
      end
    end

    alias_method_chain :handle_response, :response_capture
    alias_method_chain :request, :detailed_log_subscriber
  end
end
