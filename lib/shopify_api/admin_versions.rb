# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AdminVersions
    SUPPORTED_ADMIN_VERSIONS = T.let([
      "unstable",
      "2026-01",
      "2025-10",
      "2025-07",
      "2025-04",
      "2025-01",
      "2024-10",
      "2024-07",
      "2024-04",
      "2024-01",
      "2023-10",
      "2023-07",
      "2023-04",
      "2023-01",
      "2022-10",
      "2022-07",
      "2022-04",
      "2022-01",
    ], T::Array[String])

    LATEST_SUPPORTED_ADMIN_VERSION = T.let("2025-10", String)
    RELEASE_CANDIDATE_ADMIN_VERSION = T.let("2026-01", String)
  end

  SUPPORTED_ADMIN_VERSIONS = ShopifyAPI::AdminVersions::SUPPORTED_ADMIN_VERSIONS
  LATEST_SUPPORTED_ADMIN_VERSION = ShopifyAPI::AdminVersions::LATEST_SUPPORTED_ADMIN_VERSION
  RELEASE_CANDIDATE_ADMIN_VERSION = ShopifyAPI::AdminVersions::RELEASE_CANDIDATE_ADMIN_VERSION
end
