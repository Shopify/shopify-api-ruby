# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AdminVersions
    SUPPORTED_ADMIN_VERSIONS = T.let([
      "unstable",
      "2023-10",
      "2023-07",
      "2023-04",
      "2023-01",
      "2022-10",
      "2022-07",
      "2022-04",
      "2022-01",
    ], T::Array[String])

    LATEST_SUPPORTED_ADMIN_VERSION = T.let("2023-10", String)
  end

  SUPPORTED_ADMIN_VERSIONS = ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS
  LATEST_SUPPORTED_ADMIN_VERSION = ShopifyAPI::AdminVersions::LATEST_SUPPORTED_ADMIN_VERSION
end
