Rails.application.routes.draw do
  # resources :users, only: [:create, :show]
  post '/signup', to: 'users#create'
  get '/user', to: 'users#show'
  delete '/logout', to: 'logins#logout'
  post '/login', to: 'logins#login'

  post '/books', to: 'books#create'

  get '/userbooks', to: 'books#show'

end
