class VotesController < ApplicationController
  before_action :logged_in_user

  def create
    @votable = Submission.find(params[:votable_id])
    current_user.vote(@votable, params[:upvote])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @vote = Vote.find(params[:id]).votable
    current_user.unvote(@vote)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
