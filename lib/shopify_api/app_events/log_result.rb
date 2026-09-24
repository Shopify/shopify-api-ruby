# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AppEvents
    class LogResult < T::Struct
      # True when Shopify replayed a cached response for this idempotency key.
      const :replayed, T::Boolean
    end
  end
end
