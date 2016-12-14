module ShopifyAPI
  module AsyncResource
    extend self

    DEFAULT_WAITING_STRATEGY = -> (interval) { sleep(interval) }
    MAX_RETRIES = 500
    INTERVAL = 2

    def poll(strategy, *args, &block)
      case strategy
      when :retry
        RetryStrategy.new(*args, &block)
      when :follow_location
        FollowLocationStrategy.new(*args, &block)
      end
    end

    class RetryStrategy
      attr_reader(
        :connection,
        :max_retries,
        :interval,
        :waiting_strategy
      )

      def initialize(connection, **options, &block)
        @connection       = connection
        @max_retries      = options.fetch(:max_retries, MAX_RETRIES)
        @interval         = options.fetch(:interval, INTERVAL)
        @waiting_strategy = options.fetch(:waiting_strategy, DEFAULT_WAITING_STRATEGY)

        call(&block) if block_given?
      end

      def call
        retry_n = 0
        result = nil

        loop do
          yield
          puts "WERWER"
          break if ready?
          break if retry_n > max_retries

          retry_n += 1
          waiting_strategy.call(interval)
        end

        result
      end

      def ready?
        @connection.response.code == 200
      end
    end

    class FollowLocationStrategy < RetryStrategy
      def call
      end
    end
  end
end
