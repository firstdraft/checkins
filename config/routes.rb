Rails.application.routes.draw do
  devise_for :administrators

  authenticated :administrator do
    root "credentials#index"
  end

  root "credentials#index"

  resources :check_ins, only: [:create, :destroy]
  resources :contexts, only: [:index]
  resources :credentials, only: [:index, :create, :destroy]
  resources :enrollments, only: []
  # resources :launches, except: :create
  resource  :launch, only: :create
  resources :resources, only: :show
  resources :users, only: []
end
