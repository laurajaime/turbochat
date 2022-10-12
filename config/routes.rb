Rails.application.routes.draw do
  root 'pages#home'

  resources :rooms do
    resources :messages
    collection do
      post :search
    end
  end
  get 'rooms/leave/:id', to: 'rooms#leave', as: 'leave_room'
  get 'rooms/join/:id', to: 'rooms#join', as: 'join_room'

  get "user/:id", to: "users#show", as: "user"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
