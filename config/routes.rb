Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, except: [:show]
  resources :discs, only: [:show, :edit, :update] do
	resource :tunes, only: [:new, :create]
  end
end
