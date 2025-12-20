Rails.application.routes.draw do
root 'top#index'
resources :users
resource :logins,only:%i[new create]
resource :logouts,only: :show
resources :posts
end
