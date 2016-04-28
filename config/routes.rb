Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end
  
  resources :orders
  
  root 'orders#new'
  
end
