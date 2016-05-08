Rails.application.routes.draw do
  get 'locations/index'

  get 'locations/new'

  get 'locations/show'

  devise_for :users
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end
  
  resources :orders
  resources :products
  resources :locations
  
  root 'orders#new'
  
end
