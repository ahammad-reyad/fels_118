Rails.application.routes.draw do
  root               "static_pages#home"
  get    "help"   => "static_pages#help"
  get    "about"  => "static_pages#about"
  get    "signup" => "users#new"
  get    "login"  => "sessions#new"
  post   "login"  => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :categories
  resources :lessons
  resources :words
  namespace :admin do
    root "users#index"
    resources :users
    resources :categories
    resources :words
  end
  resources :relationships, only: [:index, :create, :destroy]
end
