Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]
  resources :user_instrument, only: [:create]
  resources :jams do
    resources :slots, only: [:create] do
      resources :requests, only: [:create]
    end
  end

end
