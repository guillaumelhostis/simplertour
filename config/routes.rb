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


  resources :tours

end
