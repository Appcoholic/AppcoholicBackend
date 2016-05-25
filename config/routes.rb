Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'my'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end
  
  resources :users
  resources :orders
  
  resources :products do
    member do
      get :price
    end
  end
  
  resources :locations
  resources :inventories
  
  get 'dashboard', to: 'products#index'
  get 'order_complete', to: 'orders#order_complete'
  
  root 'home#home'
  
end
