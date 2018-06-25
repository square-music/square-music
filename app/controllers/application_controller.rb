class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :search
 add_flash_types :success, :info, :warning, :danger

 def search
 	@search = Product.ransack(params[:q])
 end

 protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_name, :user_phonetic, :postal, :address, :tell])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_name, :user_phonetic, :postal, :address, :tell])

 end
end
