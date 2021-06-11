Rails.application.routes.draw do
  
  resources :doctors
  resources :patients
  resources :appointments

  root to: 'appointments#index'

end
