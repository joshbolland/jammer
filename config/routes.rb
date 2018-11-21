Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]
  resources :user_instruments, only: [:new, :create]
  resources :jams do
    resources :slots, only: [:new, :create] do
    end
  end
  resources :slots, only: :show do
    resources :requests, only: [:new, :create]
  end
end
