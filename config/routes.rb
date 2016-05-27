Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'my', :controllers => { :registrations => :registrations }
  
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
  
  # Additional Orders routes
  get 'track_order', to: 'orders#track_order'
  get 'order_status', to: 'orders#order_status'
  get 'assign_courier', to: 'orders#assign_courier'
  get 'accept_order', to: 'orders#accept_order'
  get 'cancel_order', to: 'orders#cancel_order'
  get 'complete_order', to: 'orders#complete_order', as: 'complete_order'
  
  
  root 'home#home'
  
end
