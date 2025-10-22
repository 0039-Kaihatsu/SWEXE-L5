class TopController < ApplicationController
  def main
    if session[:login_uid]
      render "main"
    else
      render "login"
    end
  end

  def login
    user = User.find_by(uid: params[:uid])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tweets_path, notice: "ログインしました"
    else
      redirect_to top_main_path, alert: "ログイン情報が正しくありません"
    end
  end
  
  def logout
    reset_session
    redirect_to top_main_path, notice: "ログアウトしました"
  end
end
