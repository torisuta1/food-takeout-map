Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',   
    passwords: 'users/passwords'
  } 
  resources :users, only: [:show] do 
    resource :relationship, only: [:create, :destroy] 
    resources :followings 
    resources :followers 
  end
  root to: "home#index"
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
