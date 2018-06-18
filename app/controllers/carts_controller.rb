class CartsController < ApplicationController

	# before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
    # @cart_items = current_cart.cart_items
  end

  # カートへ追加
#   def add_item
#     if @cart_item.blank?
#       @cart_item = current_cart.cart_items.build(product_id: params[:product_id])
#     end

#     @cart_item.quantity += params[:cart_quantity].to_i
#     @cart_item.save
#     redirect_to current_cart
#   end

#   # 更新
#   def update_item
#     @cart_item.update(cart_quantity: params[:cart_quantity].to_i)
#     redirect_to current_cart
#   end

# 　# 削除
#   def delete_item
#     @cart_item.destroy
#     redirect_to current_cart
#   end

  # private
#   def setup_cart_item!
#     @cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
#   end
end
