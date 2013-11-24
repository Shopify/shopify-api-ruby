module ShopifyAPI
  class Metafield < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true

    def value
      return if attributes["value"].nil?
      attributes["value_type"] == "integer" ? attributes["value"].to_i : attributes["value"]
    end
  end
end
