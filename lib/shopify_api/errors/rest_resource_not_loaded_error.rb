# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Errors
    # Raised when a REST resource class is referenced but this gem version does
    # not bundle REST resources for the active API version. Subclasses NameError
    # so existing `rescue NameError` handling keeps working.
    class RestResourceNotLoadedError < NameError; end
  end
end
