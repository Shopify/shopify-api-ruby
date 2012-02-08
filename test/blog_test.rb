require 'test_helper'
class BlogTest < Test::Unit::TestCase
  test "blog creation" do
    fake "blogs", :method => :post, :status => 202
    ShopifyAPI::Blog.create(:title => "Test Blog")
    assert_equal '{"blog":{"title":"Test Blog"}}', FakeWeb.last_request.body
  end
end
