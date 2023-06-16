Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "contact/new", to: "contacts#new"
  post "/contacts", to: "contacts#create"
  get "about_us", to: "about_us#index"



  resources :products, only: [:index, :show]


  root to: "landing_page#index"

end
