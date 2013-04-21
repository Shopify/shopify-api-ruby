require 'test_helper'

class ArticleTest < Test::Unit::TestCase

  def test_get_article
    fake "articles/6242736", :method => :get, :body => load_fixture('article')
    article = ShopifyAPI::Article.find(6242736)
    assert_equal "First Post", article.title
  end

  def test_get_articles
    fake "articles", :method => :get, :body => load_fixture('article')
    articles = ShopifyAPI::Article.all
    asert_equal 3, articles.length
  end

  def test_get_articles_namespaced
    fake "blogs/1008414260/articles", :method => :get, :body => load_fixture('article')
    articles = ShopifyAPI::Article.find(:all, :params => {:blog_id => 1008414260})
    asert_equal 3, articles.length
  end

  def test_get_article_namespaced
    fake "blogs/1008414260/articles/6242736", :method => :get, :body => load_fixture('article')
    articles = ShopifyAPI::Article.find(6242736, :params => {:blog_id => 1008414260})
    assert_equal "First Post", article.title
  end
end
