Rails.application.routes.draw do
  # Devise authentication
  devise_for :users

  # Root page
  root "notes#index"

  # Notes CRUD routes
  resources :notes do
    # Collection route for favorite notes
    collection do
      get :favorites
    end
  end
end
