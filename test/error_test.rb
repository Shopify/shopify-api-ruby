require 'test_helper'

class ErrorTest < Test::Unit::TestCase
  def test_bad_request_with_error
    fake "blogs/1008414260/articles", :method => :post, :body => load_fixture('errors'), :status => 400
    article = ShopifyAPI::Article.new(:blog_id => 1008414260)
    assert_raises ActiveResource::BadRequest do
      article.save
    end

    assert_equal ["can't be blank"], article.errors[:title]
    assert_equal ["expected String to be a Money"], article.errors[:price]
  end

  def test_bad_request_without_error
    fake "blogs/1008414260/articles", :method => :post, :body => nil, :status => 400
    article = ShopifyAPI::Article.new(:blog_id => 1008414260)

    assert_raises ActiveResource::BadRequest do
      article.save
    end

    assert_equal 0, article.errors.count
  end

  def test_unprocessable_entity_with_error
    fake "blogs/1008414260/articles", :method => :post, :body => load_fixture('errors'), :status => 422
    article = ShopifyAPI::Article.new(:blog_id => 1008414260)
    assert_equal false, article.save

    assert_equal ["can't be blank"], article.errors[:title]
    assert_equal ["expected String to be a Money"], article.errors[:price]
  end

  def test_unprocessable_entity_without_error
    fake "blogs/1008414260/articles", :method => :post, :body => nil, :status => 422
    article = ShopifyAPI::Article.new(:blog_id => 1008414260)

    assert_equal false, article.save


    assert_equal 0, article.errors.count
  end

end
