require 'test_helper'

class SubredditTest < ActiveSupport::TestCase

  def setup
    @tech = subreddits(:tech)
  end

  test "title should be the correct length" do
    @tech.title = nil
    assert_not @tech.valid?, "title must be non-nil"

    @tech.title = ""
    assert_not @tech.valid?, "title must be at least 1 character"

    22.times { @tech.title += "a" }
    assert_not @tech.valid?, "title longer than 21 characters not allowed"
  end

  test "title should be unique" do
    @other = Subreddit.new
    @other.title = @tech.title
    assert_not @other.valid?
  end

  test "slug should be generated automatically" do
    @other = Subreddit.new
    @other.title = "All about dogs"
    @other.save

    assert_equal "allaboutdogs", @other.slug
  end

  test "slug should not contain whitespace, slashes, or special characters" do
    @tech.slug = "s p a c e"
    assert_not @tech.valid?

    @tech.slug = "a/b"
    assert_not @tech.valid?

    @tech.slug = "a*"
    assert_not @tech.valid?
  end

  test "slug should be unique" do

  end
end
