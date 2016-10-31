module ShopifyAPI
  module Pollable
    extend self

    DEFAULT_POLLING_STRATEGY = -> (interval: 2) { sleep(interval) }
    MAX_RETRIES = 500
    INTERVAL = 2

    def poll(**options)
      options = defaults.merge(options)
      retry_n = 0

      loop do
        previous_response = instance_exec(&block)
        binding.pry
        break if previous_response
      end
    end

    private

    def defaults
      {
        interval: INTERVAL,
        max_retries: MAX_RETRIES,
        polling_strategy: DEFAULT_POLLING_STRATEGY,
        follow_location: true,
      }
    end

# RETRY_MAX = 500
#
# def self.poll_until_ready(klass)
#   retry_n = 1
#   result = nil
#
#   loop do
#     result = yield
#
#     break if klass.connection.response.code != '202' || retry_n > RETRY_MAX
#     retry_n += 1
#     sleep 2
#   end
#
#   result
# end
  end
end
