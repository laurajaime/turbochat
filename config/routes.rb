Rails.application.routes.draw do
  root 'pages#home'

  resources :rooms do
    resources :messages
  end

  get "user/:id", to: "users#show", as: "user"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
