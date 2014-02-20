Base::Application.routes.draw do
  resources :sessions, only: :create
  resources :password_resets, only: []
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new', :as => 'login'
  root 'manage/application#index'

  namespace :manage do
    root 'application#index'
    namespace :data do
      root 'application#index'
      resources :categories
    end
  end

end
