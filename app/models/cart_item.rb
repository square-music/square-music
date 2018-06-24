class CartItem < ApplicationRecord

  validates :cart_quantity, presence:true

  belongs_to :product
  belongs_to :cart

end
