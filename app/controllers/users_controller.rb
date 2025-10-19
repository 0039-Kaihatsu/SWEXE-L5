class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(uid: params[:user][:uid], pass: BCrypt::Password.create(params[:user][:pass]))

    if @user.save
      redirect_to top_main_path, notice: "ユーザーを作成しました"
    else
      render :new, status: 422
    end
  end

  def destroy
    u = User.find(params[:id])
    u.destroy
    redirect_to users_path, notice: "ユーザーを削除しました"
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.includes(:likes)
  end
end
