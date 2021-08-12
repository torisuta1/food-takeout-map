Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',   
    passwords: 'users/passwords'
  } 
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show] do 
    namespace :admin do 
      resources :users, only: [:destroy, :index]
    end
    resource :relationship, only: [:create, :destroy] 
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
  root to: "homes#index"
  resources :posts, only: [:new, :create, :destroy, :show, :index] do
    resource :like, only: [:create, :destroy]
    collection do 
      get 'search'
    end
    member do 
      get 'my_post'
    end
    resources :genres, only: [:new, :create, :index]
  end
end
