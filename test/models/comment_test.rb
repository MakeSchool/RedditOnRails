require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @under_post = @comment = comments(:under_post)
    @under_comment = comments(:under_comment)
  end

  test "has the expected properties" do
    assert @comment.respond_to? :commentable
    assert @comment.respond_to? :body

    @comment.commentable = nil
    assert_not @comment.valid? "comment missing parent should be invalid"
  end

  test "comment parented by post can reach parent and children" do
    @under_post.commentable.is_a? Article
    @under_post.comments.size > 0
  end

  test "comment parented by comment" do
    @under_comment.commentable.is_a? Comment
  end

end
