Rails.application.routes.draw do


  get 'unsubscribe_ccomment/new'

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

  resources :products do
    resources :reviews, only: [:create, :destroy]
  end

   get "/orders/complete" => "orders#complete"
  resources :orders

  resources :discs, only: [:show, :edit, :update] do
  resources :tunes, only: [:new, :create, :destroy]
  end

  get 'unsubscribe_comment/new' => 'unsubscribe_comment#new'
  root 'products#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end