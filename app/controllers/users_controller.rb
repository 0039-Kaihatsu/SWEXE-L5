class UsersController < ApplicationController
  # 全ユーザー一覧
  def index
    @users = User.all
  end

  # 新規ユーザー作成フォーム
  def new
    @user = User.new
  end

  # ユーザー作成処理
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to top_main_path, notice: "ユーザーを作成しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  # ユーザー削除
  def destroy
    u = User.find(params[:id])
    u.destroy
    redirect_to users_path, notice: "ユーザーを削除しました"
  end

  # ユーザー詳細（そのユーザーのツイート一覧も取得）
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.includes(:likes)
  end

  private

  def user_params
    params.require(:user).permit(:uid, :password, :password_confirmation)
  end
end
