Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
   resources :book_comments, only: [:create, :destroy]
   resource :favorites, only: [:create, :destroy]
  end
   
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :follower
    end
    resource :relationships, only: [:create, :destroy]
  end
end