Rails.application.routes.draw do
  get  "top/main"
  post "top/login"
  get  "top/logout"

  root "tweets#index"

  resources :tweets

  resources :likes, only: [:create, :destroy]
  
  resources :users, only: [:new, :create, :show]


end
