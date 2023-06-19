Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Admin area
  namespace :admin do
    root to: "dashboard#index"
    resources :products, except: :show
    resources :orders, only: [:index, :show]
  end

  get "contact/new", to: "contacts#new"
  post "/contacts", to: "contacts#create"
  get "about_us", to: "about_us#index"
  resources :basket, only: [:index]



  resources :products, only: [:index, :show] do
    member do
      get :add_to_basket
    end
  end


  root to: "landing_page#index"

end
