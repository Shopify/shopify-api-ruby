# frozen_string_literal: true
module ShopifyAPI
  class MarketingEvent < Base
    include Countable

    def add_engagements(engagements)
      engagements = { engagements: Array.wrap(engagements) }
      post(:engagements, {}, engagements.to_json)
    end
  end
end
