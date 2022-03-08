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
  get "login_sso"  => "sessions#login_sso", :as => "login_sso"
  post "logout" => "sessions#destroy", :as => "logout_post"
  get "logout" => "sessions#destroy", :as => "logout"
  

  resources :listings
  
  post "listings/favorite" => "listings#favorite", :as => "favorite"
  post "listings/request_listing" => "listings#request_listing", :as => "request_listing"
  post "listings/cancel_request" => "listings#cancel_request", :as => "cancel_request"
  get "listings/:id/pending_requests" => "listings#pending_requests", :as => "pending_requests"
  
  get "organization" => "organizations#organization", :as => "organization"
  get "organizations/:id/edit" => "organizations#edit", :as => "edit_org"
  put "organizations/:id" => "organizations#update", :as => "update_org"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
