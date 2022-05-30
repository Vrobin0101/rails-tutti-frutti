Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :products, only: %i[index show]
  resources :follow_ups, only: %i[create edit update destroy]
  get "/profile/:id", to: "pages#profile"
end
