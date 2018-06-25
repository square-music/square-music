class SubAddress < ApplicationRecord
	validates :sub_address, presence: true
	
	belongs_to :user
	has_one :orders
end
