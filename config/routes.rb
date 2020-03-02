Rails.application.routes.draw do
  resources :metrics
  resources :events
  resources :contacts
end
