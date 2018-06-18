Rails.application.routes.draw do

  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  get 'users/completion' => 'users#completion'
  devise_for :admins
  devise_for :users, :controllers => {
  :registrations => 'users/registrations'}

  devise_scope :user do
  post 'users/sign_up/confirm' => 'users/registrations#confirm'
  post 'users/sign_up/complete' => 'users/registrations#complete'
  end

  resources :users, only: [:show, :edit]
  resources :carts, only: [:show]

  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'

# 優先順位の関係で↓をココに記述してます。移動しないようにしてください（岡田）
  get '/products/search' => 'products#search'

  resources :products do
    resources :reviews, only: [:create, :destroy]
  end

   get "/orders/complete" => "orders#complete"
  resources :orders

  resources :discs, only: [:show, :edit, :update] do
  resources :tunes, only: [:new, :create, :destroy]
  end




  get 'unsubscribe_comments/new' => 'unsubscribe_comments#new'
  post 'unsubscribe_comments' => 'unsubscribe_comments#create'
  get "/order/complete" => "orders#complete"

  root 'products#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
