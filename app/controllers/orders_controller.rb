class OrdersController < ApplicationController

before_action :access_admin, only: [:index]

   def new
      @order = Order.new
      @user = User.find(params[:user_id])
      @sub_address = SubAddress.new
      @sub_addresses = SubAddress.where(user_id: @user)
      @payment = Payment.all
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
    if
      cart_item.product.stock -= order_item.order_quantity
      cart_item.product.stock  < 0
      order_item.destroy
      order.destroy
      redirect_to "/carts/#{cart.id}" 
      flash[:message] = 'そんなにいっぱい買わないでください'
      return 
    else
     cart_item.product.stock -= order_item.order_quantity
      cart_item.product.save
      cart_item.destroy
    end

      order_item.product.order_item_count += order_item.order_quantity
      order_item.product.save
    end

      redirect_to "/orders/#{order.id}/complete"
      return
   end

   def update
      order = Order.find(params[:id])
      status = Status.all
      order.update(order_params)
      redirect_to user_order_path
   end

   def destroy
    @order = Order.find(params[:id])

   end

   def index
    @orders = Order.all
   end

   def show
    @order = Order.find(params[:id])
    @user = User.find(params[:user_id])
    @status = Status.find(@order.status_id)
    @statuses = Status.all
   end

   def complete
    @order = Order.find(params[:id])
  end

   def access_admin
     unless   admin_signed_in?
       redirect_to("/")
     end
   end
   
   private
      def order_params
        params.require(:order).permit(:total_price, :order_number,
         :user_id, :status_id, :payment_id, :sub_address_id)
      end

end
