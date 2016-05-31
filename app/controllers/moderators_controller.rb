class ModeratorsController < ApplicationController
  load_and_authorize_resource
  before_action :set_moderator, only: [:show, :edit, :update, :destroy]

  def create
    @moderator = Moderator.new(moderator_params)

    respond_to do |format|
      if @moderator.save
        format.html { head :created }
        format.json { render json: @moderator, status: :created }
      else
        format.html { head :unprocessable_entity }
        format.json { render json: @moderator.errors, 
                           status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @moderator.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private

  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  def moderator_params
    params.require(:moderator).permit(:subreddit_id, :user_id)
  end
end
