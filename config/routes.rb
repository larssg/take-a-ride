Rails.application.routes.draw do
  root 'home#index'

  post 'submit', to: 'rides#create'

  resources :rides
end
