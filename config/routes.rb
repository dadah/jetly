Rails.application.routes.draw do

  resources :jetly_urls, path: '/', only: [:index, :show, :create]

  namespace :admin do
    get "sign_up" => "users#new", :as => "sign_up"
    get "log_in" => "sessions#new", :as => "log_in"
    get "log_out" => "sessions#destroy", :as => "log_out"
    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :jetly_urls, only: [:index]
  end

end
