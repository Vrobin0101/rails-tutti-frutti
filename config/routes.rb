Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :products, only: %i[index show] do
    resources :follow_ups, only: :create
  end
  resources :follow_ups, only: %i[update destroy]
  get "/profile/:id", to: "pages#profile", as: 'profile'
  post "/profile/:id", to: "pages#add_friend", as: 'add_friend'
  get "/map", to: "pages#map", as: 'map'
end
