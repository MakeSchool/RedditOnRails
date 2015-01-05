class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to submissions_url
    end
  end

  def about
  end
end
