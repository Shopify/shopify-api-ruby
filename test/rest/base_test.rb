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

    assert_equal(false, @product.respond_to?(:client))
    assert_raises(NoMethodError) { @product.client }
  end

  def test_unknown_method_names_that_are_not_instance_variable_names
    [:missing_predicate?, :missing_bang!, :"[]", :"unknown name"].each do |name|
      assert_equal(false, @product.respond_to?(name))
      assert_equal(false, @product.respond_to?(name, true))
      error = assert_raises(NoMethodError) { @product.public_send(name) }
      assert_equal(name, error.name)
    end
  end

  def test_unicode_dynamic_properties_remain_supported
    @product.public_send(:café=, "value")

    assert_equal(true, @product.respond_to?(:café))
    assert_equal("value", @product.public_send(:café))
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

  def test_optional_properties_preserve_computed_getters_and_visibility
    payment = ShopifyAPI::Payment.new(session: @product.instance_variable_get(:@session))
    payment.checkout_id = "checkout-token"

    assert_equal("checkout-token", payment.send(:get_optional_property, :checkout_id))
    assert_equal(
      "checkouts/checkout-token/payments.json",
      ShopifyAPI::Payment.get_path(http_method: :post, operation: :post, entity: payment),
    )
    assert_equal("checkout-token", payment.send(:build_required_attributes, http_method: :post)["checkout_id"])

    @product.define_singleton_method(:id) { 123 }
    assert_equal(:put, @product.send(:deduce_write_verb))
    assert_equal(123, @product.send(:build_required_attributes, http_method: :put)["id"])
    @product.define_singleton_method(:id) { nil }
    assert_nil(@product.send(:get_optional_property, :id))
    assert_equal(:post, @product.send(:deduce_write_verb))
    assert_equal(true, @product.send(:get_optional_property, :"tax_exempt?"))

    @product.singleton_class.send(:private, :id)
    assert_nil(@product.send(:get_optional_property, :id))
    @product.define_singleton_method(:id) { 456 }
    @product.singleton_class.send(:private, :id)
    assert_equal(456, @product.send(:get_optional_property, :id, include_private: true))
    assert_equal(:put, @product.send(:deduce_write_verb))
    assert_nil(ShopifyAPI::Product.get_path(http_method: :put, operation: :put, entity: @product))
  end

  def test_optional_properties_do_not_swallow_errors_inside_real_getters
    @product.define_singleton_method(:id) { raise NoMethodError, "inside getter" }

    error = assert_raises(NoMethodError) { @product.send(:deduce_write_verb) }
    assert_match(/inside getter/, error.message)
  end
end
