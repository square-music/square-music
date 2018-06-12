class Disc < ApplicationRecord
	belongs_to :product
	has_many :tunes, dependent: :destroy
	accepts_nested_attributes_for :tunes, allow_destroy: true
end
