class CartItemsController < ApplicationController
 before_action :authenticate_user!, only: [:create]
   def create
		product = Product.find_by(id:  params[:product_id])
		cart = Cart.find_by(user_id: current_user.id)
		
		if cart_item = CartItem.find_by(product_id: product.id, cart_id: cart.id)
			i = params[:cart_item][:cart_quantity]
			unless i.blank?
			cart_item.cart_quantity += i.to_i
		    cart_item.save
			redirect_to product_path(product)
			 flash[:success] = "カートに商品が入りました"
			 return
		    else
		    redirect_to product_path(product)
		     flash[:warning] = "もっと買ってください"
		     return
		    end
		else
			new_cart_item = CartItem.new(cart_item_params)
			new_cart_item.product_id = product.id
			new_cart_item.cart_id = cart.id
			if new_cart_item.save
			 redirect_to product_path(product)
			 flash[:success] = "カートに商品が入りました"
			return
		    else
		     redirect_to product_path(product)
		     flash[:warning] = "もっと買ってください"
		    return
		    end
		end
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
		if cart_item.cart_quantity == 0
			cart_item.destroy
		end
		redirect_to cart_path(cart.id)
	end

     private
	  def cart_item_params
	    params.require(:cart_item).permit(:cart_id, :cart_quantity, :product_id)
	  end
  end