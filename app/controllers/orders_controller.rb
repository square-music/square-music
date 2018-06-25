class OrdersController < ApplicationController
before_action :access_authority, only: [:show]
before_action :access_admin, only: [:index]

layout "special_layout", only: [:index]

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
      @discount = 0
      cart_items = CartItem.where(cart_id: @cart.id)
        cart_items.each do |cart_item|
          if cart_item.product.stock < cart_item.cart_quantity
            redirect_to "/carts/#{@cart.id}"
           flash[:message] = "在庫はそんなにありませんよ？？ちゃんと見てください"
          end
        end
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
    cart_items = CartItem.where(cart_id: cart.id)
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.product_id = cart_item.product.id
      order_item.order_id = order.id
      order_item.order_item_price = cart_item.product.product_price
      order_item.order_quantity = cart_item.cart_quantity
      order_item.save
       cart_item.product.stock -= order_item.order_quantity
       cart_item.product.save
       cart_item.destroy
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

      if order.status_id == 6
         order_items = OrderItem.where(order_id: order.id)
         order_items.each do |order_item|
          order_item.product.stock += order_item.order_quantity
          order_item.product.order_item_count -= order_item.order_quantity
          order_item.product.save
       end
      end
      redirect_to user_order_path
   end

   def index
    @search = Order.ransack(params[:q])
    @orders = @search.result.order(created_at: :DESC)
   end

   def show
    @order = Order.find(params[:id])
    @user = User.find(params[:user_id])
    @status = Status.find(@order.status_id)
    @statuses = Status.all
    @limit = Status.limit(4)
    @subtotal = 0
    @total_price = 0
    @discount = 0
   end

   def complete
    @order = Order.find(params[:id])
  end

   def access_admin
     unless   admin_signed_in?
       redirect_to("/")
     end
   end

  def access_authority
     unless   admin_signed_in? ||  user_signed_in? && current_user.id == params[:user_id].to_i
        redirect_to user_session_path
     end
  end

   private
      def order_params
        params.require(:order).permit(:total_price, :order_number,
         :user_id, :status_id, :payment_id, :sub_address_id)
      end
end
