require 'test_helper'

class ShopTest < Test::Unit::TestCase
  def setup
    super
    fake "shop"
    @shop = ShopifyAPI::Shop.current
  end

  def test_current_should_return_current_shop
    assert @shop.is_a?(ShopifyAPI::Shop)
    assert_equal "Apple Computers", @shop.name
    assert_equal "apple.myshopify.com", @shop.myshopify_domain
    assert_equal 690933842, @shop.id
    assert_equal "2007-12-31T19:00:00-05:00", @shop.created_at
    assert_nil @shop.tax_shipping
  end

  def test_get_metafields_for_shop
    fake "metafields"

    metafields = @shop.metafields

    assert_equal 2, metafields.length
    assert metafields.all?{|m| m.is_a?(ShopifyAPI::Metafield)}
  end

  def test_add_metafield
    fake "metafields", :method => :post, :status => 201, :body =>load_fixture('metafield')

    field = @shop.add_metafield(ShopifyAPI::Metafield.new(:namespace => "contact", :key => "email", :value => "123@example.com", :value_type => "string"))
    assert_equal '{"metafield":{"namespace":"contact","key":"email","value":"123@example.com","value_type":"string"}}', FakeWeb.last_request.body
    assert !field.new_record?
    assert_equal "contact", field.namespace
    assert_equal "email", field.key
    assert_equal "123@example.com", field.value
  end

  def test_events
    fake "events"

    events = @shop.events

    assert_equal 3, events.length
    assert events.all?{|m| m.is_a?(ShopifyAPI::Event)}
  end
end
