# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class ClientAssertionTest < Test::Unit::TestCase
      # Generated once per process: key generation is slow, and every assertion here is verified against the
      # matching public key, so which key is generated does not change any expected value.
      RSA_PRIVATE_KEY = OpenSSL::PKey::RSA.generate(2048)
      EC_PRIVATE_KEY = OpenSSL::PKey::EC.generate("prime256v1")
      FIXED_TIME = Time.at(1_760_000_000)

      def setup
        super()

        @shop = "test-shop.myshopify.com"
        @client_id = "test-client-id"
        @kid = "test-key-2026-10"
        @audience = "https://test-shop.myshopify.com/admin/oauth/access_token"
      end

      def test_create_with_rsa_key_returns_assertion_verifiable_by_the_matching_public_key
        assertion = create_assertion(private_key: RSA_PRIVATE_KEY)

        claims, header = JWT.decode(assertion, RSA_PRIVATE_KEY.public_key, true, algorithm: "RS256")

        assert_equal("RS256", header["alg"])
        assert_equal(@kid, header["kid"])
        assert_equal("JWT", header["typ"])
        assert_equal(@client_id, claims["iss"])
        assert_equal(@client_id, claims["sub"])
        assert_equal(@audience, claims["aud"])
      end

      def test_create_with_ec_p256_key_returns_assertion_verifiable_by_the_matching_public_key
        assertion = create_assertion(private_key: EC_PRIVATE_KEY)

        claims, header = JWT.decode(assertion, ec_public_key, true, algorithm: "ES256")

        assert_equal("ES256", header["alg"])
        assert_equal(@kid, header["kid"])
        assert_equal(@client_id, claims["iss"])
        assert_equal(@audience, claims["aud"])
      end

      # The server requires exactly these claims and reads only these header members. Anything extra is at
      # best ignored and at worst rejected, so the set is pinned rather than spot-checked.
      def test_create_sets_exactly_the_expected_header_members_and_claims
        claims, header = JWT.decode(create_assertion(private_key: EC_PRIVATE_KEY), nil, false)

        assert_equal(["alg", "kid", "typ"], header.keys.sort)
        assert_equal(["aud", "exp", "iat", "iss", "jti", "sub"], claims.keys.sort)
      end

      def test_create_signature_fails_verification_against_an_unrelated_public_key
        assertion = create_assertion(private_key: RSA_PRIVATE_KEY)

        assert_raises(JWT::VerificationError) do
          JWT.decode(assertion, OpenSSL::PKey::RSA.generate(2048).public_key, true, algorithm: "RS256")
        end
      end

      def test_create_sets_integer_iat_and_exp_sixty_seconds_apart_by_default
        Time.stubs(:now).returns(FIXED_TIME)

        claims = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY))

        assert_instance_of(Integer, claims["iat"])
        assert_instance_of(Integer, claims["exp"])
        assert_equal(FIXED_TIME.to_i, claims["iat"])
        assert_equal(FIXED_TIME.to_i + 60, claims["exp"])
      end

      def test_create_sets_exp_from_the_supplied_lifetime_seconds
        Time.stubs(:now).returns(FIXED_TIME)

        claims = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY, lifetime_seconds: 300))

        assert_equal(FIXED_TIME.to_i + 300, claims["exp"])
      end

      def test_create_returns_a_different_jti_on_every_call_with_identical_arguments
        Time.stubs(:now).returns(FIXED_TIME)

        first = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY))
        second = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY))

        refute_equal(first["jti"], second["jti"])
        assert_match(/\A[0-9a-f-]{36}\z/, first["jti"])
      end

      # The canonical domain is the only form `ClientCredentials.client_credentials` accepts for every shop,
      # so it is the only form the signer accepts.
      def test_create_rejects_shop_handles_full_urls_and_unified_admin_urls
        ["test-shop", "https://test-shop.myshopify.com", "https://admin.shopify.com/store/test-shop"].each do |shop|
          error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
            create_assertion(shop: shop, private_key: RSA_PRIVATE_KEY)
          end

          assert_match(/permanent myshopify.com domain in the form/, error.message)
        end
      end

      def test_create_normalizes_shop_case_and_surrounding_whitespace
        ["TEST-SHOP.MyShopify.com", "  test-shop.myshopify.com\n"].each do |shop|
          claims = decode_unverified(create_assertion(shop: shop, private_key: RSA_PRIVATE_KEY))

          assert_equal(@audience, claims["aud"])
        end
      end

      # U+212A KELVIN SIGN folds to "k" under Unicode case mapping, which would name a different real shop.
      def test_create_rejects_a_shop_whose_name_only_becomes_canonical_under_unicode_case_folding
        assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(shop: "test-sho\u212A.myshopify.com", private_key: RSA_PRIVATE_KEY)
        end
      end

      def test_create_uses_an_explicit_audience_override_verbatim
        claims = decode_unverified(
          create_assertion(
            shop: @shop,
            private_key: RSA_PRIVATE_KEY,
            audience: " https://test-shop.shopify.io/admin/oauth/access_token\n",
          ),
        )

        assert_equal("https://test-shop.shopify.io/admin/oauth/access_token", claims["aud"])
      end

      def test_create_rejects_a_blank_audience_override
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(shop: @shop, private_key: RSA_PRIVATE_KEY, audience: "  ")
        end

        assert_match(/audience must be a non-empty String/, error.message)
      end

      # Underscore handles exist, and both ShopValidator::HOSTNAME_REGEX and the token endpoint accept them.
      def test_create_accepts_an_underscore_in_the_shop_handle
        claims = decode_unverified(create_assertion(shop: "my_shop.myshopify.com", private_key: RSA_PRIVATE_KEY))

        assert_equal("https://my_shop.myshopify.com/admin/oauth/access_token", claims["aud"])
      end

      def test_create_rejects_a_shop_on_a_trusted_but_non_permanent_domain
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(shop: "test-shop.myshopify.io", private_key: RSA_PRIVATE_KEY)
        end

        assert_match(/permanent myshopify.com domain/, error.message)
      end

      def test_create_rejects_an_untrusted_shop_domain
        assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(shop: "attacker.example", private_key: RSA_PRIVATE_KEY)
        end
      end

      def test_create_defaults_client_id_to_the_configured_api_key
        claims = decode_unverified(
          ShopifyAPI::Auth::ClientAssertion.create(shop: @shop, kid: @kid, private_key: RSA_PRIVATE_KEY),
        )

        assert_equal(ShopifyAPI::Context.api_key, claims["iss"])
        assert_equal(ShopifyAPI::Context.api_key, claims["sub"])
      end

      def test_create_prefers_an_explicit_client_id_over_the_configured_api_key
        claims = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY))

        refute_equal(ShopifyAPI::Context.api_key, @client_id)
        assert_equal(@client_id, claims["iss"])
      end

      def test_create_rejects_an_omitted_client_id_when_no_api_key_is_configured
        modify_context(api_key: "")

        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          ShopifyAPI::Auth::ClientAssertion.create(shop: @shop, kid: @kid, private_key: RSA_PRIVATE_KEY)
        end

        assert_match(/client_id must be a non-empty String/, error.message)
      end

      def test_create_rejects_a_blank_client_id
        ["", "   "].each do |client_id|
          error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
            create_assertion(client_id: client_id, private_key: RSA_PRIVATE_KEY)
          end

          assert_match(/client_id must be a non-empty String/, error.message)
        end
      end

      def test_create_rejects_a_blank_kid
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(kid: " ", private_key: RSA_PRIVATE_KEY)
        end

        assert_match(/kid must be a non-empty String/, error.message)
      end

      # Both are matched exactly by the server, so an untrimmed value can only ever fail there.
      def test_create_trims_surrounding_whitespace_from_client_id_and_kid
        assertion = create_assertion(
          client_id: " #{@client_id}\n",
          kid: " #{@kid} \n",
          private_key: RSA_PRIVATE_KEY,
        )

        claims, header = JWT.decode(assertion, nil, false)

        assert_equal(@client_id, claims["iss"])
        assert_equal(@client_id, claims["sub"])
        assert_equal(@kid, header["kid"])
      end

      def test_create_rejects_a_kid_longer_than_the_registrable_maximum
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(kid: "k" * 256, private_key: RSA_PRIVATE_KEY)
        end

        assert_match(/kid must be at most 255 characters/, error.message)
      end

      def test_create_accepts_a_kid_of_the_registrable_maximum_length
        kid = "k" * 255

        _claims, header = JWT.decode(create_assertion(kid: kid, private_key: RSA_PRIVATE_KEY), nil, false)

        assert_equal(kid, header["kid"])
      end

      def test_create_rejects_lifetime_seconds_outside_one_to_three_hundred_without_clamping
        [0, -1, 301, 3600].each do |lifetime_seconds|
          error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
            create_assertion(private_key: RSA_PRIVATE_KEY, lifetime_seconds: lifetime_seconds)
          end

          assert_match(/lifetime_seconds must be between 1 and 300/, error.message)
        end
      end

      def test_create_accepts_the_boundary_lifetimes_of_one_and_three_hundred_seconds
        Time.stubs(:now).returns(FIXED_TIME)

        [1, 300].each do |lifetime_seconds|
          claims = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY, lifetime_seconds:))

          assert_equal(FIXED_TIME.to_i + lifetime_seconds, claims["exp"])
        end
      end

      def test_create_rejects_a_non_integer_lifetime_seconds
        assert_raises(TypeError) do
          create_assertion(private_key: RSA_PRIVATE_KEY, lifetime_seconds: "60")
        end
      end

      def test_create_rejects_an_rsa_key_below_two_thousand_forty_eight_bits
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(private_key: OpenSSL::PKey::RSA.generate(1024))
        end

        assert_match(/at least 2048 bits/, error.message)
      end

      def test_create_rejects_an_ec_key_on_a_curve_other_than_p256
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(private_key: OpenSSL::PKey::EC.generate("secp384r1"))
        end

        assert_match(/must use the P-256 curve/, error.message)
      end

      def test_create_rejects_an_rsa_public_key
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(private_key: OpenSSL::PKey::RSA.new(RSA_PRIVATE_KEY.public_to_pem))
        end

        assert_match(/must be an RSA private key, not a public key/, error.message)
      end

      def test_create_rejects_an_ec_public_key
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          create_assertion(private_key: ec_public_key)
        end

        assert_match(/must be an EC private key, not a public key/, error.message)
      end

      def test_create_rejects_an_unsupported_key_type
        [RSA_PRIVATE_KEY.to_pem, { pem: "key" }, :key].each do |private_key|
          assert_raises(TypeError) { create_assertion(private_key:) }
        end
      end

      # sorbet-runtime truncates the offending value to its first and last few characters, which for a PEM
      # are the BEGIN and END lines.
      def test_create_rejects_a_pem_string_without_echoing_the_key_body
        pem = RSA_PRIVATE_KEY.to_pem
        key_body = T.must(pem.lines[1..-2]).join.delete("\n")

        error = assert_raises(TypeError) { create_assertion(private_key: pem) }

        refute_includes(error.message, key_body)
      end

      # Reachable only for an app that has turned sorbet-runtime's call validation off, which is why the
      # runtime check is still there.
      def test_validated_key_rejects_an_unsupported_key_type_without_echoing_the_supplied_value
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          ShopifyAPI::Auth::ClientAssertion.send(:validated_key_with_algorithm, { pem: "SUPER-SECRET-KEY" })
        end

        assert_equal(
          "private_key must be an OpenSSL::PKey::RSA or OpenSSL::PKey::EC private key, got: Hash",
          error.message,
        )
        refute_includes(error.message, "SECRET")
      end

      def test_create_signs_without_a_configured_api_secret_key
        modify_context(api_key: "", api_secret_key: "")

        claims = decode_unverified(create_assertion(private_key: RSA_PRIVATE_KEY))

        assert_equal(@client_id, claims["iss"])
      end

      private

      def create_assertion(shop: @shop, client_id: @client_id, kid: @kid, private_key:, **options)
        ShopifyAPI::Auth::ClientAssertion.create(shop:, client_id:, kid:, private_key:, **options)
      end

      def decode_unverified(assertion)
        JWT.decode(assertion, nil, false)[0]
      end

      def ec_public_key
        OpenSSL::PKey::EC.new(EC_PRIVATE_KEY.public_to_pem)
      end
    end
  end
end
