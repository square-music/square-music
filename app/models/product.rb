class Product < ApplicationRecord
	belongs_to :artist
	belongs_to :label
	belongs_to :genre
	has_many :discs, dependent: :destroy
	has_many :reviews, dependent: :destroy
	has_many :cart_items, dependent: :destroy
	attachment :image
	validates :product_name, :product_phonetic, :product_price, :disc_amount, :release, :stock, :description, :artist_id, :label_id, :genre_id, presence: true
end