# typed: true
# frozen_string_literal: true

require_relative "../../test_helper"

module ShopifyAPITest
  module Auth
    module IdToken
      class GoogleIdTokenTest < Test::Unit::TestCase
        def setup
          super
          @sample_jwt = <<~EOS
            eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJ0ZXN0LXNob3AubXlzaG9waWZ5LmlvIn0.CnoHeW_Z0oMKQcBPqezcbFyWLlkioPKPz8X0wchUkeQ
          EOS
        end

        def test_successful_requests_returns_id_token
          stub_request(:get, "http://metadata/computeMetadata/v1/instance/service-accounts/default/identity?audience=test-shop.myshopify.io&format=full")
            .with(headers: { "Metadata-Flavor" => "Google" })
            .to_return(body: @sample_jwt, status: 200)

          assert_equal(@sample_jwt, ShopifyAPI::Auth::IdToken::GoogleIdToken.request(shop: "test-shop.myshopify.io"))
        end

        def test_unsuccessful_requests_returns_nil
          stub_request(:get, "http://metadata/computeMetadata/v1/instance/service-accounts/default/identity?audience=test-shop.myshopify.io&format=full")
            .with(headers: { "Metadata-Flavor" => "Google" })
            .to_return(status: 404)

          assert_nil(ShopifyAPI::Auth::IdToken::GoogleIdToken.request(shop: "test-shop.myshopify.io"))
        end
      end
    end
  end
end
