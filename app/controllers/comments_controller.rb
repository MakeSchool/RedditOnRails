class CommentsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :edit, :destroy]
  before_action :correct_user,    only: [:edit, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.commentable_id = params[:commentable_id]
    @comment.commentable_type = params[:commentable_type]
    if @comment.save
      redirect_to subreddit_submission_path(subreddit_id: @comment.commentable.subreddit.name, id: @comment.commentable.id)
      flash[:success] = "Comment added!"
    else
      redirect_to subreddit_submission_path(subreddit_id: @comment.commentable.subreddit.name, id: @comment.commentable.id)
      flash[:danger] = "Comment could not be added! :("
    end
  end

  def edit
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to subreddit_submission_url(subreddit_id: @comment.commentable.subreddit.name,
                                    id: @comment.commentable.id)
                      flash[:success] = "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    submission = @comment.commentable
    @comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to subreddit_submission_url(subreddit_id: submission.subreddit.name,
                                id: submission.id)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      if @comment.nil?
        if !current_user.admin
          flash[:danger] = "You do not have permission to do that."
          redirect_to root_url
        end
        @comment = Comment.find(params[:id])
      end
    end
end
