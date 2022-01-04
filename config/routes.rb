Rails.application.routes.draw do

  root 'hesti#home'

  get 'new_account' => 'hesti#new_account', :as => 'new_account'
  post 'create_account' => 'hesti#create_account', :as => "create_account"
  get 'log_in'  => 'hesti#log_in', :as => 'log_in'
  post 'log_in_auth'  => 'hesti#log_in_auth', :as => "log_in_auth"
  post 'log_out' => 'hesti#log_out', :as => 'log_out'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
