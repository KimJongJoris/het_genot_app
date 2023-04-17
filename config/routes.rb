Rails.application.routes.draw do
  get "contact/new", to: "contacts#new"
  post "/contacts", to: "contacts#create"
end
