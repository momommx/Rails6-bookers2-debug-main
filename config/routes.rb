Rails.application.routes.draw do
  
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  
  get "admin" => "admin/users#index"
  namespace :admin do
    resources :users, only: [:index, :update]
  end
  
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
   resources :book_comments, only: [:create, :destroy]
   resource :favorites, only: [:create, :destroy]
   resources :tags, only: [:index, :show, :destroy]
  end
   
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :follower
    end
    resource :relationships, only: [:create, :destroy]
  end
end