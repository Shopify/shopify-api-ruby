module ShopifyAPI
  module Pollable
    ACCEPTED_RESPONSE_CODE = "202"
    INTERVAL_HEADER = "Retry-After"
    LOCATION_HEADER = "Location"

    def self.included(klass)
      klass.extend(ClassMethods)
      klass.polling_max_retries = 35
      klass.polling_interval = 500
      klass.polling_enabled = true
      klass.use_suggested_interval = true
    end

    module ClassMethods
      attr_accessor(
        :polling_max_retries,
        :polling_interval,
        :polling_enabled,
        :use_suggested_interval,
      )

      def with_polling(enabled = true)
        @old_polling_enabled, @polling_enabled = @polling_enabled, enabled
        yield
      ensure
        @polling_enabled = @old_polling_enabled
      end

      def without_polling(&block)
        without_polling(false, &block)
      end

      def polling_enabled?
        !!@polling_enabled
      end
    end

    private

    def load_attributes_from_response(response)
      ready_response = poll_from_previous_response(response)
      super(ready_response)
    end

    def ready?(response)
      response.code == ACCEPTED_RESPONSE_CODE
    end

    def poll_from_previous_response(response)
      return response unless polling_enabled?
      return response if ready?(response)

      poll do
        connection.get()
      end
    end

    def poll
      retry_n = 0
      result = nil

      loop do
        result = yield

        break if ready?(result)
        break if retry_n > self.class.max_retries

        retry_n += 1
        sleep(self.class.polling_interval)
      end

      result
    end
  end
end
