require 'test_helper'

class SubredditNavigationTest < ActionDispatch::IntegrationTest

  def setup
    @tech = subreddits(:tech)
    @andy = users(:andy)
  end

  test "anon user can reach a valid subreddit by slug path" do
    get subreddit_slug_path slug: @tech.slug
    assert_response :success
    get subreddit_slug_path slug: "doesnotexist"
    assert_response :not_found
  end

  test "anon user can see a list of articles on a subreddit page" do
    get subreddit_slug_path slug: @tech.slug
    assert_response :success

    @tech.articles.each do |article|
      assert_select "li", { text: article.title }
    end
  end

  test "logged in user can post an article" do
    get new_user_session_path
    post user_session_path user: { email: @andy.email, password: 'password' }
    get subreddit_slug_path slug: @tech.slug
    assert_select "a[href=?]", new_subreddit_article_path(@tech.id)
    get new_subreddit_article_path(@tech.id)
    assert_template "articles/new"
  end

  # test "anon user is redirected when attempt to post article" do
  #
  # end
end
