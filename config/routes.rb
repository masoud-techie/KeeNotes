Rails.application.routes.draw do

  # Devise authentication
  devise_for :users

  # Root page
  root "pages#index"

  get "note_shares/create"
  get "note_shares/destroy"
  get "pages/home"

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

  resources :todo_lists, only: [:index, :create, :show, :new, :destroy] do
    resources :todo_items, only: [:create]
  end

  resources :todo_items, only: [:update, :destroy]


end
