class SubredditsController < ApplicationController
  before_action :set_subreddit, only: [:show, :edit, :update, :destroy]

  # GET /subreddits
  # GET /subreddits.json
  def index
    @subreddits = Subreddit.paginate(page: params[:page])
  end

  # GET /subreddits/1
  # GET /subreddits/1.json
  def show
    @submissions = @subreddit.submissions.paginate(page: params[:page])
  end

  # GET /subreddits/new
  def new
    @subreddit = current_user.created_subreddits.build if logged_in?
  end

  # GET /subreddits/1/edit
  def edit
  end

  # POST /subreddits
  # POST /subreddits.json
  def create
    @subreddit = current_user.created_subreddits.build(subreddit_params)

    respond_to do |format|
      if @subreddit.save
        format.html { redirect_to @subreddit
                      flash[:sucess] = "r/#{@subreddit.name} created." }
        format.json { render :show, status: :created, location: @subreddit }
        current_user.subscriptions.build(subreddit: @subreddit).save
      else
        format.html { render :new }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subreddits/1
  # DELETE /subreddits/1.json
  def destroy
    @subreddit.destroy
    respond_to do |format|
      format.html { redirect_to subreddits_url
                    flash[:success] = "r/#{@subreddit.name} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subreddit
      @subreddit = Subreddit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subreddit_params
      params.require(:subreddit).permit(:name, :moderator)
    end
end
