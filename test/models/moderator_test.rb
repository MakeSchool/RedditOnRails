require 'test_helper'

class ModeratorTest < ActiveSupport::TestCase
  def setup
    @andy = users(:andy)
    @cats = subreddits(:cats)
  end

  test "can moderator multiple subreddits" do
    assert 1, @andy.moderating.size
    # add a second moderator assignment
    moderator = Moderator.new(user: @andy, subreddit: @cats)
    assert 2, @andy.moderating.size
  end
end
