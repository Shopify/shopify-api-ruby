# frozen_string_literal: true
module ShopifyAPI
  module Ping
    class Message < Base
      self.prefix = "#{api_prefix}api/ping-api/v1/conversations/:conversation_id/"
    end
  end
end
