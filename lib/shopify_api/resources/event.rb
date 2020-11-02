# frozen_string_literal: true
module ShopifyAPI
  class Event < Base
    include DisablePrefixCheck

    conditional_prefix :resource, true
    early_july_pagination_release!
  end
end
