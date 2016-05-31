require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @andy = users(:andy)
    @bob = users(:bob)
    @tech = subreddits(:tech)
    @cats = subreddits(:cats)
    @by_andy_in_tech = articles(:by_andy_in_tech)
    @by_bob_in_tech = articles(:by_bob_in_tech)
    @by_bob_in_cats = articles(:by_bob_in_cats)

  end

  test "can create an article on any subreddit" do
    sign_in @andy
    assert_difference('Article.count', 2) do
      [@tech, @cats].each do |subreddit|
        post :create, subreddit_id: subreddit.id,
              article: { title: "my article", url: "http://yahoo.com" }
      end
    end
    # assert_equal 1, Article.where(subreddit_id: @tech.id).count
  end

  test "can delete my own article" do
    sign_in @andy
    assert_difference('Article.count', -1) do
      delete :destroy, id: @by_andy_in_tech
    end
  end

  test "cannot delete another person's article when not a moderator or owner" do
    sign_in @andy
    assert_no_difference('Article.count') do
      delete :destroy, id: @by_bob_in_cats
    end
  end

  test "can delete another person's article when subreddit owner (but not moderator)" do
    subreddit_owner = @andy
    sign_in subreddit_owner

    assert_difference('Article.count', -1) do
      delete :destroy, id: @by_bob_in_tech
    end
  end

  test "can delete another person's article when a moderator" do
    sign_in @bob
    assert_difference('Article.count', -1) do
      delete :destroy, id: @by_andy_in_tech
    end
  end
end
