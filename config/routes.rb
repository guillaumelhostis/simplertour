Rails.application.routes.draw do
  devise_for :tourmen, controllers: {
    sessions: 'tourman/sessions',
    registrations: 'tourman/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  root to: 'pages#home'
  get  'pages/user'
  get 'pages/tourman'

  resources :venues
  resources :hotels


  resources :tours do
    resources :concerts, except: [:index] do
      patch :remove_venue, on: :member
      patch :remove_hotel, on: :member
      resources :concert_hotels, only: [:create, :destroy] do
        member do
          delete 'remove_user/:user_id', action: :remove_user, as: 'remove_user'
          post 'add_crew', action: :add_crew, as: 'add_crew'
        end
      end
    end
  end

  resources :crews do
    member do
      post 'assign_users'
      delete 'unassign_user/:user_id', action: :unassign_user, as: :unassign_user
    end
  end

end
