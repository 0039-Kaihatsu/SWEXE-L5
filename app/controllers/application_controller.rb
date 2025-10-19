class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user


  def L4
    session[:c] ||= 0
    session[:c] = session[:c].to_i + 1
    render plain: session[:c]
  end
  
  def current_user
    @current_user ||= User.find_by(uid: session[:login_uid]) || User.find_by(id: session[:user_id])
  end
end
