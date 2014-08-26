class SessionsController < ApplicationController
  def linkedin_create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:success] = "Logged in!"
    return redirect_to :root
  end

  def linkedin_destroy
    if current_user && current_user.linkedin_id.present?
      #current_user.linkedin_id = nil
      #current_user.linkedin_data = nil
      current_user.destroy
      reset_session
    end
    flash[:success] = 'LinkedIn connection removed, you may wish to <a href="https://www.linkedin.com/secure/settings?userAgree" target="_blank">deauthorise the app</a>'.html_safe
    return redirect_to :root
  end
  
  def destroy
    reset_session
    flash[:notice] = "Logged out!"
    return redirect_to :root
  end

  def omniauth_failure
    flash[:error] = "Authentication failed, please try again."
    return redirect_to :root
  end

end
