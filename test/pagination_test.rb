require 'test_helper'

class PaginationTest < Test::Unit::TestCase
  def setup
    super

    @version = ShopifyAPI::ApiVersion.find_version('2019-10')
    ShopifyAPI::Base.api_version = @version.to_s
    @next_page_info = "eyJkaXJlY3Rpb24iOiJuZXh0IiwibGFzdF9pZCI6NDQwMDg5NDIzLCJsYXN0X3ZhbHVlIjoiNDQwMDg5NDIzIn0%3D"
    @previous_page_info = "eyJsYXN0X2lkIjoxMDg4MjgzMDksImxhc3RfdmFsdWUiOiIxMDg4MjgzMDkiLCJkaXJlY3Rpb24iOiJuZXh0In0%3D"

    @next_link_header = "<https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?page_info=#{@next_page_info}>; rel=\"next\""
    @previous_link_header = "<https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?page_info=#{@previous_page_info}>; rel=\"previous\""
  end

  test "navigates using next and previous link headers with no original params" do
    link_header ="#{@previous_link_header}, #{@next_link_header}"

    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => link_header
    orders = ShopifyAPI::Order.all

    fake(
      'orders',
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?page_info=#{@next_page_info}",
      method: :get,
      status: 200,
      body: load_fixture('orders')
    )
    next_page = orders.fetch_next_page
    assert_equal 450789469, next_page.first.id

    fake(
      'orders',
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?page_info=#{@previous_page_info}",
      method: :get,
      status: 200,
      body: load_fixture('orders').gsub("450789469", "1122334455")
    )

    previous_page = orders.fetch_previous_page
    assert_equal 1122334455, previous_page.first.id
  end

  test "uses all passed in querystring parameters" do
    params = "page_info=#{@next_page_info}&limit=50&fields=#{CGI.escape('id,created_at')}"
    @next_link_header = "<https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?#{params}>; rel=\"next\""
    fake(
      'orders',
      method: :get,
      status: 200,
      api_version: @version,
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?fields=id%2Cupdated_at&limit=100",
      body: load_fixture('orders'),
      link: @next_link_header
    )
    orders = ShopifyAPI::Order.where(fields: 'id,updated_at', limit: 100)

    fake(
      'orders',
      method: :get,
      status: 200,
      api_version: @version,
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?fields=id%2Ccreated_at&limit=50&page_info=#{@next_page_info}",
      body: load_fixture('orders')
    )
    next_page = orders.fetch_next_page
    assert_equal 450789469, next_page.first.id
  end

  test "returns empty next page if just the previous page is present" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => @previous_link_header
    orders = ShopifyAPI::Order.all

    next_page = orders.fetch_next_page
    assert_empty next_page
  end

  test "returns an empty previous page if just the next page is present" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => @next_link_header
    orders = ShopifyAPI::Order.all

    next_page = orders.fetch_previous_page
    assert_empty next_page
  end

  test "#next_page? returns true if next page is present" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => @next_link_header
    orders = ShopifyAPI::Order.all

    assert orders.next_page?
  end

  test "#next_page? returns false if next page is not present" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => @previous_link_header
    orders = ShopifyAPI::Order.all

    refute orders.next_page?
  end

  test "#previous_page? returns true if previous page is present" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => @previous_link_header
    orders = ShopifyAPI::Order.all

    assert orders.previous_page?
  end

  test "#previous_page? returns false if next page is not present" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => @next_link_header
    orders = ShopifyAPI::Order.all

    refute orders.previous_page?
  end

  test "pagination handles no link headers" do
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders')
    orders = ShopifyAPI::Order.all

    refute orders.next_page?
    refute orders.previous_page?
    assert_empty orders.fetch_next_page
    assert_empty orders.fetch_previous_page
  end

  test "raises on invalid pagination links" do
    link_header = "<https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?page_info=#{@next_page_info}>;"
    fake 'orders', :method => :get, :status => 200, api_version: @version, :body => load_fixture('orders'), :link => link_header

    assert_raises ShopifyAPI::InvalidPaginationLinksError do
      ShopifyAPI::Order.all
    end
  end

  test "raises on an older API version" do
    version = ShopifyAPI::ApiVersion.find_version('2019-04')
    ShopifyAPI::Base.api_version = version.to_s

    fake 'orders', :method => :get, :status => 200, api_version: version, :body => load_fixture('orders')
    orders = ShopifyAPI::Order.all

    assert_raises NotImplementedError do
      orders.fetch_next_page
    end
  end

  test "raises on 2019-07 API version for models that don't support new pagination yet" do
    version = ShopifyAPI::ApiVersion.find_version('2019-07')
    ShopifyAPI::Base.api_version = version.to_s

    fake 'orders', :method => :get, :status => 200, api_version: version, :body => load_fixture('orders')
    orders = ShopifyAPI::Order.all

    assert_raises NotImplementedError do
      orders.fetch_next_page
    end
  end

  test "new pagination works on 2019-07 API version for select models" do
    version = ShopifyAPI::ApiVersion.find_version('2019-07')
    ShopifyAPI::Base.api_version = version.to_s

    fake 'events', :method => :get, :status => 200, api_version: version, :body => load_fixture('events')
    events = ShopifyAPI::Event.all

    assert_empty events.fetch_next_page
    assert_empty events.fetch_previous_page
  end

  test "does not raise on the unstable version" do
    version = ShopifyAPI::ApiVersion.find_version('unstable')
    ShopifyAPI::Base.api_version = version.to_s
    @next_link_header = "<https://this-is-my-test-shop.myshopify.com/admin/api/unstable/orders.json?page_info=#{@next_page_info}>; rel=\"next\""

    link_header ="#{@previous_link_header}, #{@next_link_header}"

    fake 'orders', :method => :get, :status => 200, api_version: version, :body => load_fixture('orders'), :link => link_header
    orders = ShopifyAPI::Order.all

    fake(
      'orders',
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/unstable/orders.json?page_info=#{@next_page_info}",
      method: :get,
      status: 200,
      body: load_fixture('orders')
    )
    assert_nothing_raised do
      next_page = orders.fetch_next_page
      assert_equal 450789469, next_page.first.id
    end
  end

  test "allows for multiple concurrent API collection objects" do
    first_request_params = "page_info=#{@next_page_info}&limit=5"
    fake(
      'orders',
      method: :get,
      status: 200,
      api_version: @version,
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?limit=5",
      body: load_fixture('orders'),
      link: "<https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?#{first_request_params}>; rel=\"next\""
    )
    orders = ShopifyAPI::Order.where(limit: 5)

    second_request_params = "page_info=#{@next_page_info}&limit=5"
    fake(
      'orders',
      method: :get,
      status: 200,
      api_version: @version,
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?limit=10",
      body: load_fixture('orders'),
      link: "<https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?#{second_request_params}>; rel=\"next\""
    )

    orders2 = ShopifyAPI::Order.where(limit: 10)

    fake(
      'orders',
      method: :get,
      status: 200,
      api_version: @version,
      url: "https://this-is-my-test-shop.myshopify.com/admin/api/2019-10/orders.json?limit=5&page_info=#{@next_page_info}",
      body: load_fixture('orders')
    )
    next_page = orders.fetch_next_page
    assert_equal 450789469, next_page.first.id
  end

end
