require 'test_helper'

class ModeratorsControllerTest < ActionController::TestCase

  def setup
    @creator_of_tech_subreddit = users(:andy)
    @moderator_of_tech = users(:bob)
    @other_user = users(:alice)
    @tech = subreddits(:tech)
    @cats = subreddits(:cats)
  end

  test "anonymous user cannot add moderator" do
    assert_no_difference('Moderator.count') do
      post :create, moderator: { user: @other_user, subreddit: @tech }
    end
  end

  test "subreddit creator can add moderator in same subreddit" do
    sign_in @creator_of_tech_subreddit
    assert_difference('Moderator.count', 1) do
      post :create, moderator: { user_id: @other_user.id, subreddit_id: @tech.id }
    end
  end

  test "subreddit creator can delete moderator in same subreddit" do
    sign_in @creator_of_tech_subreddit
    other_moderator = @tech.moderators.find { |x| x != @creator_of_tech_subreddit }
    assert_difference('Moderator.count', -1) do
      delete :destroy, id: other_moderator
    end
  end

  test "subreddit creator cannot add moderator in different subreddit" do
    sign_in @creator_of_tech_subreddit
    assert_no_difference('Moderator.count') do
      post :create, moderator: { user_id: @other_user.id, subreddit_id: @cats.id }
    end
  end

  test "moderator can add other moderators to same subreddit" do
    sign_in @moderator_of_tech
    assert_difference('Moderator.count', 1) do
      post :create, moderator: { user_id: @other_user.id, subreddit_id: @tech.id }
    end
  end
end
