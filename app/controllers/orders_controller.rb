class OrdersController < ApplicationController

   def new
      @order = Order.new
      @user = User.find(params[:user_id])
      @sub_address = SubAddress.new
      @sub_addresses = SubAddress.where(user_id: @user)
      @payment = Payment.all
      @status = Status.all
      @cart = Cart.find_by(user_id: @user.id)
      @subtotal = 0
      @total_quantity = 0
      @total_price = 0
   end

  def create
    order = Order.new(order_params)
    user = User.find(params[:user_id])
    if sub_address = SubAddress.find_by(sub_address: params[:sub_address][:sub_address])
      order.sub_address_id = sub_address.id
    else
      new_sub_address = SubAddress.create(sub_address: params[:sub_address][:sub_address],user_id:user.id)
      order.sub_address_id = new_sub_address.id
    end
    order.user_id = user.id
    order.save

    cart = Cart.find_by(user_id: user.id)
    cart_items =CartItem.where(cart_id: cart.id)
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.product_id = cart_item.product.id
      order_item.order_id = order.id
      order_item.order_item_price = cart_item.product.product_price
      order_item.order_quantity = cart_item.cart_quantity
      order_item.save
      minus_stock = cart_item.product.stock - order_item.order_quantity
      cart_item.product.update(stock: minus_stock)
      cart_item.destroy
    end
      redirect_to "/orders/#{order.id}/complete"
   end

   def update
   end

   def destroy
    @order = Order.find(params[:id])

   end

   def index
    @orders = Order.all
   end

   def show
       @order = Order.find(params[:id])
   end

   def complete
    @order = Order.find(params[:id])
   end

   private
      def order_params
        params.require(:order).permit(:total_price, :order_number,
         :user_id, :status_id, :payment_id, :sub_address_id)
      end

end
