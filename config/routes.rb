Rails.application.routes.draw do
  root 'articles#index'

  resources :users do
    resources :articles, only: [:new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  resources :articles, only: [:show, :index] do
    resources :comments, only: [:index]
  end

  get "login", to: "authentication#new"
  post "login", to: "authentication#create"
  delete "logout", to: "authentication#destroy"
end
