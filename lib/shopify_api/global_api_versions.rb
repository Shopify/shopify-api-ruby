# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module GlobalApiVersions
    SUPPORTED_GLOBAL_API_VERSIONS = T.let([
      "unstable",
      "2026-10",
      "2026-07",
    ], T::Array[String])
  end

  SUPPORTED_GLOBAL_API_VERSIONS = ShopifyAPI::GlobalApiVersions::SUPPORTED_GLOBAL_API_VERSIONS
end
