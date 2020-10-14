require 'test_helper'
class TaxServiceTest < Test::Unit::TestCase
  test "tax service creation" do
    fake("tax_services", method: :post, status: 202, body: load_fixture('tax_service'))
    ShopifyAPI::TaxService.create(name: "My Tax Service", url: "https://mytaxservice.com")
    assert_equal(
      '{"tax_service":{"name":"My Tax Service","url":"https://mytaxservice.com"}}',
      WebMock.last_request.body
    )

  end
end
