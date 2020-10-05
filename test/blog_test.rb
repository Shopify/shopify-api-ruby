require 'test_helper'
class BlogTest < Test::Unit::TestCase
  test "blog creation" do
    fake "blogs", :method => :post, :status => 202, :body => load_fixture('blog')
    ShopifyAPI::Blog.create(:title => "Test Blog")
    assert_equal '{"blog":{"title":"Test Blog"}}', WebMock.last_request.body
  end
end
