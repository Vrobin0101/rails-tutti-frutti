Rails.application.routes.draw do
  devise_for :users
  root to: "pages#welcome"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :products, only: %i[index show] do
    resources :follow_ups, only: :create
  end
  resources :follow_ups, only: %i[update destroy]
  get "/profile/:id", to: "pages#profile", as: 'profile'
  get "/profile/:id", to: "pages#add_friend", as: 'add_friend'
  get "/map", to: "pages#map", as: 'map'
  get "/export/:id", to: "pages#export", as: "export"
  get "/home", to: "pages#home"
  get "/about", to: "pages#about"
end
