class CartItemsController < ApplicationController
 before_action :authenticate_user!, only: [:create]
   def create
		product = Product.find_by(id:  params[:product_id])
		cart = Cart.find_by(user_id: current_user.id)

		if cart_item = CartItem.find_by(product_id: product.id, cart_id: cart.id)
			i = params[:cart_item][:cart_quantity]
			cart_item.cart_quantity += i.to_i
			cart_item.save
		else
			new_cart_item = CartItem.new(cart_item_params)
			new_cart_item.product_id = product.id
			new_cart_item.cart_id = cart.id
			new_cart_item.save
		 end

	    redirect_to product_path(product)

	end

	def destroy
		cart_item = CartItem.find(params[:id])
		cart = Cart.find_by(user_id: current_user.id)
		cart_item.destroy
		redirect_to cart_path(cart.id)
	end

	def update
		cart_item = CartItem.find(params[:id])
		cart = Cart.find_by(user_id: current_user.id)
		cart_item.update(cart_item_params)
		redirect_to cart_path(cart.id)
	end

     private
	  def cart_item_params
	    params.require(:cart_item).permit(:cart_id, :cart_quantity, :product_id)
	  end
  end