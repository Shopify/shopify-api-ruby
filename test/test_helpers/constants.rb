# typed: strict
# frozen_string_literal: true

module TestHelpers
  module Constants
    DEFAULT_CLIENT_HEADERS = T.let({
      "Content-Type": "application/json",
      "Accept": "application/json",
      "User-Agent": "Shopify API Library v#{ShopifyAPI::VERSION} | Ruby #{RUBY_VERSION}",
      "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
    }, T::Hash[Symbol, String])
  end
end
