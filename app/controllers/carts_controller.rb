class CartsController < ApplicationController

	# before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
    @cart_items = CartItem.where(cart_id: params[:id])
    @total_price = 0
    @subtotal = 0
  end

end
