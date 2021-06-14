Rails.application.routes.draw do
  
  resources :doctors
  resources :patients
  resources :appointments

  post "show", to: "dashboards#show"

  root to: 'dashboards#show'

end
