class SubscriptionsController < ApplicationController
  def create
    @subreddit = Subreddit.find(params[:subreddit_id])
    current_user.subscribe(@subreddit)
    respond_to do |format|
      format.html { redirect_to @subreddit }
      format.js
    end
  end

  def destroy
    @subreddit = Subscription.find(params[:id]).subreddit
    current_user.unsubscribe(@subreddit)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
