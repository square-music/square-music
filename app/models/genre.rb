class Genre < ApplicationRecord
	has_many :product, dependent: :destroy
	validates :genre_name, presence: true
end
