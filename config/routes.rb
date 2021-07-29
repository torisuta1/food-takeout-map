Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',   
    passwords: 'users/passwords'
    
  } 

  root to: "home#index"
  resources :posts, only: [:new, :create, :destroy, :show, :index] do
    collection do 
      get 'search'
    end
  end
  resources :genres, only: [:new, :create, :index]
end
