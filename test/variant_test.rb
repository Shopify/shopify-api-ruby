require 'test_helper'

class VariantTest < Test::Unit::TestCase

  def test_get_variants
    fake "products/632910392/variants", :method => :get, :body => load_fixture('variants')

    v = ShopifyAPI::Variant.find(:all, :params => {:product_id => 632910392})
  end

  def test_get_variant_namespaced
    fake "products/632910392/variants/808950810", :method => :get, :body => load_fixture('variant')

    v = ShopifyAPI::Variant.find(808950810)
  end

  def test_get_variant
    fake "variants/808950810", :method => :get, :body => load_fixture('variant')

    v = ShopifyAPI::Variant.find(808950810)
  end
end
