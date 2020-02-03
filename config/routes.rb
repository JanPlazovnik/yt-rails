Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations' }
  
  resources :profile do
    member do
      get "uploads", to: "profile#uploads"
      put "follow", to: "profile#follow"
      put "unfollow", to: "profile#unfollow"
    end
  end
  
  resources :videos do
    member do
      put "like", to: "videos#upvote"
      put "dislike", to: "videos#downvote"
    end
  end

  resources :comments

  resources :search, :only => [:index]

  root to: 'videos#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
