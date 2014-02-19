Base::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destory]
  resources :password_resets, only: []
  get "sessions/new"
  root 'posts#index'
end
