class SubredditsController < ApplicationController
  before_action :set_subreddit, only: [:show, :edit, :update, :destroy]

  # GET /subreddits
  # GET /subreddits.json
  def index
    @subreddits = Subreddit.all
  end

  # GET /subreddits/1
  # GET /subreddits/1.json
  def show
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
    @subreddit = Subreddit.new(subreddit_params)

    respond_to do |format|
      if @subreddit.save
        format.html { redirect_to @subreddit, notice: 'Subreddit was successfully created.' }
        format.json { render :show, status: :created, location: @subreddit }
      else
        format.html { render :new }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subreddits/1
  # PATCH/PUT /subreddits/1.json
  def update
    respond_to do |format|
      if @subreddit.update(subreddit_params)
        format.html { redirect_to @subreddit, notice: 'Subreddit was successfully updated.' }
        format.json { render :show, status: :ok, location: @subreddit }
      else
        format.html { render :edit }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subreddits/1
  # DELETE /subreddits/1.json
  def destroy
    @subreddit.destroy
    respond_to do |format|
      format.html { redirect_to subreddits_url, notice: 'Subreddit was successfully destroyed.' }
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
