class Review < ApplicationRecord
	belongs_to :product
	belongs_to :user

	 validates :comment, presence: true ,  length: { minimum: 2 }
	 validates :star, presence: true ,  length: { minimum: 1 }
end
