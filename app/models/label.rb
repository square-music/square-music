class Label < ApplicationRecord
	has_many :product, dependent: :destroy
	validates :label_name, presence: true
end
