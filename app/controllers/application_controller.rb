class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 before_action :configure_permitted_parameters, if: :devise_controller?

 helper_method :current_cart
 def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

 protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_name, :user_phonetic, :postal, :address, :tell])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_name, :user_phonetic, :postal, :address, :tell])

 end
end
