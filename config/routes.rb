Base::Application.routes.draw do

  get 'logout' => 'sessions#destroy'
  get 'login' => 'sessions#new'
  get 'forgot_password' => 'password_resets#new'
  get 'reset_password/:id' => 'password_resets#edit'

  resources :sessions, only: :create
  resources :password_resets, only: [:create, :update]

  namespace :manage do
    root 'application#index'
    namespace :data do
      root 'application#index'
      resources :categories
    end
    resources :users
  end

  root 'manage/application#index'
end
