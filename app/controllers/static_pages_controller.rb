class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to submissions_path
    end
  end

  def about
  end
end
