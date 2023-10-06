Rails.application.routes.draw do
  devise_for :tourmen, controllers: {
    sessions: 'tourman/sessions',
    registrations: 'tourman/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  get '/pages/search', to: 'pages#search'

  root to: 'pages#home'
  get  'pages/user'
  get 'pages/tourman'

  get 'pdf_generator/generate_pdf/:id', to: 'pdf_generator#generate_pdf', as: 'generate_pdf'

  resources :venues
  resources :hotels
  resources :checklist_templates, only: [:new, :create]


  resources :tours do
    resources :concerts, except: [:index] do
      resources :timetable_entries, only: [:create, :destroy, :update]
      resources :contacts, only: [:create, :destroy, :update]
      resources :guests, only: [:create, :destroy, :update]
      resources :notes, only: [:create, :destroy, :update]
      resources :checklists, only: [:create, :destroy, :update] do
        collection do
          get 'import'
        end
      end
      delete 'removetimetable/:timetable_entry_id', action: :removetimetable, as: 'removetimetable'
      delete 'remove_contact/:contact_id', action: :remove_contact, as: 'remove_contact'
      patch :remove_venue, on: :member
      patch :remove_hotel, on: :member
      resources :concert_hotels, only: [:create, :destroy] do
        member do
          delete 'remove_user/:user_id', action: :remove_user, as: 'remove_user'
          delete 'remove_guest/:guest_id', action: :remove_guest, as: 'remove_guest'
          post 'add_crew', action: :add_crew, as: 'add_crew'
          post 'add_guest', action: :add_guest, as: 'add_guest'
        end
      end
    end
  end

  resources :crews do
    member do
      post 'assign_users'
      put 'assign_users_role'
      put 'update_role_in_crew_member/:user_id', to: 'crews#update_role_in_crew_member', as: :update_role_in_crew_member
      delete 'unassign_user/:user_id', action: :unassign_user, as: :unassign_user
    end
  end

end
