Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',   
    passwords: 'users/passwords'
    
  } 

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy" 
    post "sign_up", to:"users/registrations#create"
    post "sign_in", to:"users/sessions#create"
    get "users/password", to: "users/passwords#new"
  end
  root to: "home#index"
  
end
