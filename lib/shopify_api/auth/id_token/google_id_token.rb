# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module IdToken
      class GoogleIdToken
        METADATA_IDENTITY_URL = "http://metadata/computeMetadata/v1/instance/service-accounts/default/identity"

        class << self
          extend T::Sig

          sig { params(shop: String).returns(T.nilable(String)) }
          def request(shop:)
            response = HTTParty.get(
              "#{METADATA_IDENTITY_URL}?audience=#{shop}&format=full",
              headers: {
                "Metadata-Flavor" => "Google",
              },
            )

            return unless response.success?

            response.body
          end
        end
      end
    end
  end
end
