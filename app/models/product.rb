class Product < ApplicationRecord
	belongs_to :artist, optional: true
	belongs_to :label, optional: true
	belongs_to :genre, optional: true
	has_many :discs, dependent: :destroy
	has_many :reviews, dependent: :destroy
	mount_uploader :image_id, ImageIdUploader
end
