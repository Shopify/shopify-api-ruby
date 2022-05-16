# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AdminVersions
    SUPPORTED_ADMIN_VERSIONS = T.let([
      "unstable",
      "2022-04",
      "2022-01",
      "2021-10",
      "2021-07",
      "2021-04",
    ], T::Array[String])

    LATEST_SUPPORTED_ADMIN_VERSION = T.let("2022-04", String)
  end

  SUPPORTED_ADMIN_VERSIONS = ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS
  LATEST_SUPPORTED_ADMIN_VERSION = ShopifyAPI::AdminVersions::LATEST_SUPPORTED_ADMIN_VERSION
end
