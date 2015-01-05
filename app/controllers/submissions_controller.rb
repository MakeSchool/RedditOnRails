class SubmissionsController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: :destroy

  def new
    @submission = current_user.submissions.build if logged_in?
    @link = Link.new
  end

  def create
    @submission = current_user.submissions.build(submission_params)
    @link = Link.create(params[:submission][:link].permit(:url))
    @submission.postable = @link
    if @submission.save
      redirect_to @submission
      flash[:success] = "Post submitted!"
    else
      render :new
    end
  end

  def index
    @submissions = Submission.paginate(page: params[:page])
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def destroy
    @submission.destroy
    flash[:success] = "Post deleted."
    redirect_to root_url
  end

  private
    def submission_params
      params.require(:submission).permit(:title)
    end

    def correct_user
      @submission = current_user.submissions.find_by(id: params[:id])
      redirect_to root_url if @submission.nil?
    end
end
