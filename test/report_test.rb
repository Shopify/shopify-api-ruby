require 'test_helper'

class ReportTest < Test::Unit::TestCase
  test 'get should get a report' do
    fake('reports/987', method: :get, status: 200, body: load_fixture('report'))

    report = ShopifyAPI::Report.find(987)
    assert_equal(987, report.id)
  end

  test 'get all should get all reports' do
    fake('reports', method: :get, status: 200, body: load_fixture('reports'))

    reports = ShopifyAPI::Report.all
    assert_equal('custom_app_reports', reports.first.category)
  end

  test 'create should create a report' do
    fake('reports', method: :post, status: 201, body: load_fixture('report'))

    report = ShopifyAPI::Report.create(
      name: 'Custom App Report',
      shopify_ql: 'SHOW quantity_count, total_sales BY product_type, vendor, product_title ' \
        'FROM products SINCE -1m UNTIL -0m ORDER BY total_sales DESC'
    )
    assert_equal('custom_app_reports', report.category)
  end

  test 'delete should delete report' do
    fake('reports/987', method: :get, status: 200, body: load_fixture('report'))
    fake('reports/987', method: :delete, status: 200, body: '[]')

    report = ShopifyAPI::Report.find(987)
    assert(report.destroy)
  end
end
