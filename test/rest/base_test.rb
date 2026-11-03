# typed: strict
# frozen_string_literal: true

require_relative "../test_helper"

class RestBaseTest < Test::Unit::TestCase
  def setup
    super

    session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "token")
    attributes = { title: "T-shirt", published_at: nil }
    attributes[:"tax_exempt?"] = true
    @product = ShopifyAPI::Product.new(
      session: session,
      from_hash: attributes,
    )
  end

  def test_missing_dynamic_getters_raise_and_are_not_reported_as_supported
    assert_equal(false, @product.respond_to?(:missing_attribute))
    assert_raises(NoMethodError) { @product.missing_attribute }
    assert_equal(false, @product.respond_to?(:missing_attribute))

    assert_equal(false, @product.respond_to?(:session))
    assert_raises(NoMethodError) { @product.session }
  end

  def test_respond_to_recognises_dynamic_properties_including_nil_and_aliased_values
    assert_equal(true, @product.respond_to?(:title))
    assert_equal(true, @product.respond_to?(:published_at))
    assert_equal(true, @product.respond_to?(:tax_exempt?))
  end

  def test_dynamic_setters_remain_supported
    assert_equal(true, @product.respond_to?(:custom_field=))

    @product.custom_field = nil

    assert_equal(true, @product.respond_to?(:custom_field))
    assert_nil(@product.custom_field)

    @product.custom_field = "custom value"

    assert_equal(true, @product.respond_to?(:custom_field))
    assert_equal("custom value", @product.custom_field)
  end

  def test_write_operations_treat_missing_resource_ids_as_nil
    feedback = ShopifyAPI::ResourceFeedback.new(
      session: ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "token"),
    )

    assert_equal(:post, feedback.send(:deduce_write_verb))
    assert_equal({}, feedback.send(:build_required_attributes, http_method: :post))
    assert_equal(
      "products.json",
      ShopifyAPI::Product.get_path(http_method: :get, operation: :get, entity: feedback, ids: {}),
    )
  end
end
