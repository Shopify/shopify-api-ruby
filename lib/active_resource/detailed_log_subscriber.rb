module ActiveResource
  class DetailedLogSubscriber < ActiveSupport::LogSubscriber
    def request(event)
      log_request_response_details(event)
      warn_on_deprecated_header(event)
    end

    def logger
      ActiveResource::Base.logger
    end

    private

    def log_request_response_details(event)
      data = event.payload[:data]
      headers = data.extract_options!
      request_body = data.first

      info "Request:\n#{request_body}" if request_body
      info "Headers: #{headers.inspect}"
      info "Response:\n#{event.payload[:response].body}"
    end

    def warn_on_deprecated_header(event)
      payload = event.payload

      payload[:response].each do |header_name, header_value|
        case header_name.downcase
        when 'x-shopify-api-deprecated-reason'
          warning_message = <<~MSG
            [DEPRECATED] ShopifyAPI made a call to #{payload[:method].upcase} #{payload[:path]}, and this call made
            use of a deprecated endpoint, behaviour, or parameter. See #{header_value} for more details.
          MSG

          warn warning_message
        end
      end
    end
  end
end

ActiveResource::DetailedLogSubscriber.attach_to :active_resource_detailed
