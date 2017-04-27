module ShopifyAPI
  class MarketingEvent < Base
    def add_engagements(engagements)
      engagements = {engagements: Array(engagements)}
      post(:engagements, {}, engagements.to_json)
    end
  end
end
