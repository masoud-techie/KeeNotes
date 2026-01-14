Rails.application.routes.draw do
  get "note_shares/create"
  get "note_shares/destroy"
  get "pages/home"
  # Devise authentication
  devise_for :users

  # Root page
  root "pages#index"

  # Notes CRUD routes
  resources :notes do
    # Collection route for favorite notes
    collection do
      get :favorites
      get :archived
      get :recycle_bin
      delete :empty_recycle_bin
    end

    member do
      patch :toggle_favorite
      patch :archive
      patch :unarchive
      patch :restore
      delete :destroy_permanently
    end

    resources :note_shares, only: :create
  end

  resources :note_shares, only: :destroy


end
