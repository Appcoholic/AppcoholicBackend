Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'my'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end
  
  resources :users
  resources :orders
  resources :products
  resources :locations
  resources :inventories
  
  get 'dashboard', to: 'products#index'
  
  root 'home#home'
  
end
