Rails.application.routes.draw do
  resources :attendees, only: [:create, :show, :index]
  resources :posts
  resources :events 
  # resources :users

  get '/events/:id', to: 'events#show'

  get "/me", to: "users#show"
  # post "/register", to: "users#register"
  match '/register', to: 'users#register', via: [:options, :post]
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/users_statistics", to: "users#count"
  get "/events_statistics", to: "events#count"
  get "/category_statistics", to: "events#category_count"
  get "/date_statistics", to: "events#date_count"
  get "/attendee_statistics", to: "attendees#attendee_count"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
