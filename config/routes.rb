Rails.application.routes.draw do  
  # root "index" => "application#index", :as => "root"
  root "application#index"

  get "signup" => "users#new", :as => "signup"
  post "create" => "users#create", :as => "create_user"
  get "edit" => "users#edit", :as => "edit_user"
  put "update" => "users#update", :as => "update_user"
  get "profile" => "users#show", :as => "profile"
  delete "destroy" => "users#destroy", :as => "deactivate"

  get "login"  => "sessions#login", :as => "login"
  post "login"  => "sessions#create", :as => "login_post"
  post "logout" => "sessions#destroy", :as => "logout_post"
  get "logout" => "sessions#destroy", :as => "logout"


  resources :listings

  post "listings/favorite" => "listings#favorite", :as => "favorite"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
