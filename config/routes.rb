# config/routes.rb
Rails.application.routes.draw do
  
  # Routes untuk login dan register
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy', as: :logout

  get 'register', to: 'registrations#new', as: :register
  post 'register', to: 'registrations#create'


  get 'dashboard', to: 'dashboard#index', as: :dashboard
  resources :users
  resources :roles
  resources :genders
  resources :gurus
  resources :kelas
  resources :spps
  resources :bukus
  resources :peminjams
  resources :inventaris
  resources :tagihans
  resources :siswas
  resources :spps, only: [:index, :edit, :update, :destroy] do
    collection do
      get 'export'
    end
    member do
      get 'print_invoice'
      get 'generate_invoice' # Ini adalah member route karena memerlukan ID SPP
    end
  end
  namespace :api do
    resources :inventaris
    resources :bukus
  end
  

  # Root route (sesuaikan dengan kebutuhan)
  root 'sessions#new'
end