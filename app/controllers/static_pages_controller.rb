class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to feed_path
    end
  end

  def about
  end
end
