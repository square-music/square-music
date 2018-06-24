Rails.application.routes.draw do

  get 'genres/show'

  get '/users/:id/soft_delete' => 'users#soft_delete'
  get '/users/:id/restoration' => 'users#restoration'
  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  get 'users/completion' => 'users#completion'
  devise_for :admins
  devise_for :users, :controllers => {
  :registrations => 'users/registrations'}

  devise_scope :user do
  post 'users/sign_up/confirm' => 'users/registrations#confirm'

  end

   get "/orders" => "orders#index"
  
   get "/orders/:id/complete" => "orders#complete"
  resources :users, only: [:index, :show, :edit, :update] do
    resources :orders , only: [:new, :create, :update, :destroy, :show]
  end
  resources :carts, only: [:show]


  # 優先順位の関係で↓をココに記述してます。移動しないようにしてください（岡田）
  get '/products/search' => 'products#search'

  resources :products do
    resources :cart_items, only: [:create, :destroy, :update]
    resources :reviews, only: [:create, :destroy]
  end

   get "/orders/complete" => "orders#complete"


  resources :discs, only: [:show, :edit, :update] do
  resources :tunes, only: [:new, :create, :destroy]
  end

  resources :genres, only: [:show]

  get '/unsubscribe_comments/complete' => 'unsubscribe_comments#complete'
  get 'unsubscribe_comments/new' => 'unsubscribe_comments#new'
  post 'unsubscribe_comments' => 'unsubscribe_comments#create'
  post '/products/:product_id/discs' => 'discs#create'
  get "/order/complete" => "orders#complete"

  # コンタクト
  resources :contacts, only: [:index, :new, :create, :destroy]
  get '/about' => 'contacts#about'
  get '/question' => 'contacts#question'

  root 'products#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
