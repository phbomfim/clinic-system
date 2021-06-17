Rails.application.routes.draw do
  
  resources :doctors
  resources :patients
  resources :appointments

  get "show", to: "dashboards#show"
  post "show", to: "dashboards#show"

  root to: 'dashboards#show'

end
