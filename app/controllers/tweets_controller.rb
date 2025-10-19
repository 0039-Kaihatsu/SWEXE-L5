class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    if session[:user_id]
      tweet = Tweet.new(tweet_params)
      tweet.user_id = session[:user_id]
      if tweet.save
        redirect_to tweets_path, notice: "ツイートしました"
      else
        render :new
      end
    else
      redirect_to top_main_path, alert: "ログインしてください"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == session[:user_id]
      tweet.destroy
      redirect_to root_path, notice: '削除しました'
    else
      redirect_to root_path, alert: '自分の投稿以外は削除できません'
    end
  end
  
  private

  def tweet_params
    params.fetch(:tweet, {}).permit(:message)
  end
end
