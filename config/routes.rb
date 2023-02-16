Rails.application.routes.draw do
  # get 'errors/not_found'
  # get 'errors/internal_server_error'
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "kittens#index"
  resources :kittens
end
