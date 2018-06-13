class CartsController < ApplicationController

	before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
  
  end

end
