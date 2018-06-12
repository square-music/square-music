class Label < ApplicationRecord
	has_many :product, dependent: :destroy
end
