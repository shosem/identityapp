Rails.application.routes.draw do
root "top#index"
resources :users
get "login", to: "user_sessions#new"
post "login", to: "user_sessions#create"
delete "logout", to: "user_sessions#destroy"
resources :posts do
  resources :comments, only: %i[create edit update destroy]
end
end
