Rails.application.routes.draw do
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
    end
  end
end
