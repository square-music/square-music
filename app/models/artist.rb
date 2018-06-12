class Artist < ApplicationRecord
	has_many :products, dependent: :destroy
	has_many :tunes, dependent: :destroy
end
