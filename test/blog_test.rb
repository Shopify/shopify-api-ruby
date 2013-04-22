require 'test_helper'
class BlogTest < Test::Unit::TestCase
  test "blog creation" do
    fake "blogs", :method => :post, :status => 202
    blog = ShopifyAPI::Blog.new(:title => "Test Blog")
    assert_equal "Test Blog", blog.title
  end
end
