require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @article = articles(:first)
  end

  test "title should be valid" do
    @article.title = ''
    assert_not @article.valid?
  end

  test "body can be empty if url is not" do
    @article.url = 'http://example.com'
    @article.body = ''
    assert @article.valid?
  end

  test "url can be empty if body is not" do
    @article.url = ''
    @article.body = "Non-empty"
    assert @article.valid?
  end

  test "url and body cannot both be empty" do
    @article.url = @article.body = ''
    assert_not @article.valid?
  end

  test "url and body cannot both be present" do
    @article.url = "http://example.com"
    @article.body = "non-empty"
    assert_not @article.valid?
  end

  test "must be attached to a subreddit" do
    @article.subreddit = nil
    assert_not @article.valid?
  end

  test "url must be valid" do
    @article.url = "not-valid"
    assert_not @article.valid?
  end

  test "text post has correct link" do
    @article.url = "http://example.com"
    @article.body = nil
    own_path = "http://example.com/wrong"
    assert_equal @article.url, @article.view_link(own_path)
  end

  test "url post has correct link" do
    @article.url = nil
    @article.body = "has a body"
    own_path = "http://example.com/right"
    assert_equal own_path, @article.view_link(own_path)
  end
end
