Base::Application.routes.draw do
  resources :sessions, only: :create
  resources :password_resets, only: []
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  root 'posts#index'
end
