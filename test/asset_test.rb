# frozen_string_literal: true
require 'test_helper'

class AssetTest < Test::Unit::TestCase
  def test_get_assetss
    fake("themes/1/assets", method: :get, body: load_fixture('assets'))
    ShopifyAPI::Asset.find(:all, params: { theme_id: 1 })
  end

  def test_get_asset_namespaced
    fake(
      "themes/1/assets.json?asset%5Bkey%5D=templates%2Findex.liquid&theme_id=1",
      extension: false,
      method: :get,
      body: load_fixture('asset')
    )
    ShopifyAPI::Asset.find('templates/index.liquid', params: { theme_id: 1 })
  end

  def test_get_asset
    fake(
      "assets.json?asset%5Bkey%5D=templates%2Findex.liquid", extension: false, method: :get, body: load_fixture('asset')
    )
    ShopifyAPI::Asset.find('templates/index.liquid')
  end
end
