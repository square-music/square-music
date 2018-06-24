class Order < ApplicationRecord
	belongs_to :sub_address
	has_many :order_items
	has_many :products, :through=> :order_items
	belongs_to :payment
	belongs_to :status
	belongs_to :user
end
