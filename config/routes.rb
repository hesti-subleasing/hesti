Rails.application.routes.draw do

  root "hesti#home"

  get "signup" => "hesti#new_account", :as => "new_account"
  post "create_account" => "hesti#create_account", :as => "create_account"
  get "login"  => "hesti#login", :as => "login"
  post "login_auth"  => "hesti#login_auth", :as => "login_auth"
  post "logout" => "hesti#logout", :as => "logout"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
