Rails.application.routes.draw do
  devise_for :users
  get "contact/new", to: "contacts#new"
  post "/contacts", to: "contacts#create"

  resources :products, only: [:index, :show]

end
