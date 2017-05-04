module ShopifyAPI
  class MarketingEvent < Base
    def add_engagements(engagements)
      engagements = { engagements: Array.wrap(engagements) }
      post(:engagements, {}, engagements.to_json)
    end
  end
end
