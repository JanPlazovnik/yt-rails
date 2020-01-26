Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :profile do
    member do
      get "uploads", to: "profile#uploads"
      put "follow", to: "profile#follow"
      put "unfollow", to: "profile#unfollow"
    end
  end

  resources :videos do
    resources :comments
    member do
      put "like", to: "videos#upvote"
      put "dislike", to: "videos#downvote"
    end
  end

  root to: 'videos#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
