class CartsController < ApplicationController
before_action :access_authority, only: [:show]
	# before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
    @cart_items = CartItem.where(cart_id: params[:id])
    @total_price = 0
  end
  def access_authority
    unless  admin_signed_in? || user_signed_in? && current_user.id == params[:id].to_i
      redirect_to user_session_path
    end
  end
end
