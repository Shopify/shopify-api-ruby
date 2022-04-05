# frozen_string_literal: true
module ShopifyAPI
  class Metafield < Base
    include DisablePrefixCheck

    NEW_TYPES_IN_VERSION = ShopifyAPI::ApiVersion.find_version("2021-07")

    conditional_prefix :resource, true
    early_july_pagination_release!

    def value
      return if attributes["value"].nil?

      if ShopifyAPI::Base.api_version >= NEW_TYPES_IN_VERSION
        %w[integer number_integer].include?(attributes["type"]) ? attributes["value"].to_i : attributes["value"]
      else
        attributes["value_type"] == "integer" ? attributes["value"].to_i : attributes["value"]
      end
    end
  end
end
