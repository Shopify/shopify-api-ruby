module ActiveResource
  class DetailedLogSubscriber < ActiveSupport::LogSubscriber
    def request(event)
      data = event.payload[:data]
      headers = data.extract_options!
      request_body = data.first

      info "Request:\n#{request_body}" if request_body
      info "Headers: #{headers.inspect}"
      info "Response:\n#{event.payload[:response].body}"
    end

    def logger
      ActiveResource::Base.logger
    end
  end
end

ActiveResource::DetailedLogSubscriber.attach_to :active_resource_detailed
