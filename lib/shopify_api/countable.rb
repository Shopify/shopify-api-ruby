# frozen_string_literal: true
module ShopifyAPI
  module Countable
    def count(options = {})
      data = get(:count, options)

      count = case data
      when Hash then data["count"]
      else data
      end

      Integer(count)
    end
  end
end
