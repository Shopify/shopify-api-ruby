# frozen_string_literal: true
module ActiveResource
  class DetailedLogSubscriber < ActiveSupport::LogSubscriber
    VERSION_EOL_WARNING_HEADER = 'x-shopify-api-version-warning'
    VERSION_DEPRECATION_HEADER = 'x-shopify-api-deprecated-reason'
    SHOPIFY_ACCESS_TOKEN = 'X-Shopify-Access-Token'
    FILTERED = '[FILTERED]'

    def request(event)
      log_request_response_details(event)
      warn_on_deprecated_header_or_version_eol_header(event)
    end

    def logger
      ActiveResource::Base.logger
    end

    private

    def log_request_response_details(event)
      data = event.payload[:data]
      headers = data.extract_options!
      headers[SHOPIFY_ACCESS_TOKEN] = FILTERED
      request_body = data.first

      info("Request:\n#{request_body}") if request_body
      info("Headers: #{headers.inspect}")
      info("Response:\n#{event.payload[:response].body}")
    end

    def warn_on_deprecated_header_or_version_eol_header(event)
      payload = event.payload

      payload[:response].each do |header_name, header_value|
        case header_name.downcase
        when VERSION_DEPRECATION_HEADER
          warning_message = <<-MSG
          [DEPRECATED] ShopifyAPI made a call to #{payload[:method].upcase} #{payload[:path]}, and this call made
          use of a deprecated endpoint, behaviour, or parameter. See #{header_value} for more details.
          MSG

          warn(warning_message)

        when VERSION_EOL_WARNING_HEADER
          warning_message = <<-MSG
          [API Version Warning] ShopifyAPI made a call to #{payload[:method].upcase} #{payload[:path]}, and this call used
          an API version that is unsupported or will become unsupported within 30 days. See #{header_value} for more details.
          MSG

          warn(warning_message)
        end
      end
    end
  end
end
