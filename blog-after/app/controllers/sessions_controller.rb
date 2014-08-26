class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:success] = "Logged in!"
    return render :close_window if params[:oauth_token].present?
    return redirect_to :root
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    return redirect_to :root
  end

  def omniauth_failure
    flash[:error] = "Authentication failed, please try again."
    return redirect_to :root
  end

end
