class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid username/password combination.'
      render 'new'
    end
  end

  def create_facebook
    user =  User.where(:provider => auth_hash['provider'],
                    :uid => auth_hash['uid']).first || User.create_with_omniauth(auth_hash)
    log_in user
    redirect_to '/'
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
