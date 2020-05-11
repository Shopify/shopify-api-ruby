require 'test_helper'

class BulkOperationUtilTest < Test::Unit::TestCase
  def test_with_nested_children_connections_mixed_ordered
    url = "https://example.myshopify.com/files/products.json"

    data = <<~JSON
      {"id":"gid://shopify/Product/1921569651651"}
      {"id":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/ProductVariant/194354589324927","title":"66","__parentId":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/ProductVariant/19435458986040","title":"70","__parentId":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/Product/1921569325112"}
      {"id":"gid://shopify/ProductVariant/19435459084344","title":"36","__parentId":"gid://shopify/Product/1921569325112"}
      {"id":"gid://shopify/Product/1921569357880"}
      {"id":"gid://shopify/ProductVariant/19435459117112","title":"47","__parentId":"gid://shopify/Product/1921569357880"}
      {"id":"gid://shopify/ProductVariant/19435458986123","title":"52","__parentId":"gid://shopify/Product/1921569226808"}
    JSON

    stub_request(:get, url).to_return(body: data)

    nodes = []

    ShopifyAPI::BulkOperationUtil.open_with_nested_connections(url) do |node|
      nodes << node
    end

    expected_results = [
      {"id"=>"gid://shopify/Product/1921569357880", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435459117112", "title"=>"47"}]},
      {"id"=>"gid://shopify/Product/1921569325112", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435459084344", "title"=>"36"}]},
      {"id"=>"gid://shopify/Product/1921569226808", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435458986123", "title"=>"52"}, {"id"=>"gid://shopify/ProductVariant/19435458986040", "title"=>"70"}, {"id"=>"gid://shopify/ProductVariant/194354589324927", "title"=>"66"}]},
      {"id"=>"gid://shopify/Product/1921569651651", "__children"=>[]}
    ]

    assert_equal expected_results, nodes
  end

  def test_with_nested_children_connections_ordered
    url = "https://example.myshopify.com/files/products.json"

    data = <<~JSON
      {"id":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/ProductVariant/194354589324927","title":"66","__parentId":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/ProductVariant/19435458986123","title":"52","__parentId":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/Product/1921569325112"}
      {"id":"gid://shopify/ProductVariant/19435459084344","title":"36","__parentId":"gid://shopify/Product/1921569325112"}
    JSON

    stub_request(:get, url).to_return(body: data)

    nodes = []

    ShopifyAPI::BulkOperationUtil.open_with_nested_connections(url) do |node|
      nodes << node
    end

    expected_results = [
      {"id"=>"gid://shopify/Product/1921569325112", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435459084344", "title"=>"36"}]},
      {"id"=>"gid://shopify/Product/1921569226808", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435458986123", "title"=>"52"}, {"id"=>"gid://shopify/ProductVariant/194354589324927", "title"=>"66"}]},
    ]

    assert_equal expected_results, nodes
  end

  def test_with_nested_children_connections_unordered
    url = "https://example.myshopify.com/files/products.json"

    data = <<~JSON
      {"id":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/Product/1921569325112"}
      {"id":"gid://shopify/Product/1921569325342"}
      {"id":"gid://shopify/ProductVariant/194354589324927","title":"66","__parentId":"gid://shopify/Product/1921569226808"}
      {"id":"gid://shopify/ProductVariant/19435459084502","title":"99","__parentId":"gid://shopify/Product/1921569325342"}
      {"id":"gid://shopify/ProductVariant/19435459084344","title":"36","__parentId":"gid://shopify/Product/1921569325112"}
    JSON

    stub_request(:get, url).to_return(body: data)

    nodes = []

    ShopifyAPI::BulkOperationUtil.open_with_nested_connections(url) do |node|
      nodes << node
    end

    expected_results = [
      {"id"=>"gid://shopify/Product/1921569325342", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435459084502", "title"=>"99"}]},
      {"id"=>"gid://shopify/Product/1921569325112", "__children"=>[{"id"=>"gid://shopify/ProductVariant/19435459084344", "title"=>"36"}]},
      {"id"=>"gid://shopify/Product/1921569226808", "__children"=>[{"id"=>"gid://shopify/ProductVariant/194354589324927", "title"=>"66"}]},
    ]

    assert_equal expected_results, nodes
  end

  def test_with_raises_error_with_bad_json
    url = "https://example.myshopify.com/sneaky.json"

    data = <<~JSON
      {"id":"gid://shopify/Product/1921569651651"}
      {id: gid://shopify/ProductVariant/19435458986342}
      {"id":"gid://shopify/ProductVariant/19435458986123","title":"52","__parentId":"gid://shopify/Product/1921569226808"}
    JSON

    stub_request(:get, url).to_return(body: data)

    assert_raises(JSON::ParserError) do
      ShopifyAPI::BulkOperationUtil.open_with_nested_connections(url) {}
    end
  end

  def test_with_raises_error_with_bad_request
    url = "https://example.myshopify.com/customers.json"

    response_body = <<~XML
      <?xml version='1.0' encoding='UTF-8'?>
      <Error><Code>ExpiredToken</Code>
      <Message>The provided token has expired.</Message>
      <Details>Request signature expired at: 1970-01-01T00:26:29+00:00</Details>
      </Error>
    XML

    stub_request(:get, url).to_return(body: response_body, status: 400)

    assert_raises(OpenURI::HTTPError) do
      ShopifyAPI::BulkOperationUtil.open_with_nested_connections(url) {}
    end
  end
end
