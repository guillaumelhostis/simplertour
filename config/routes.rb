Rails.application.routes.draw do
  devise_for :tourman, controllers: {
    sessions: 'tourman/sessions',
    registrations: 'tourman/registrations'
  }

  devise_for :user, controllers: {
    sessions: 'user/sessions'
  }

  root to: 'pages#home'
  get  'pages/user'
  get 'pages/tourman'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
