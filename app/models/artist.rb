class Artist < ApplicationRecord
	has_many :products, dependent: :destroy
	has_many :tunes, dependent: :destroy
	validates :artist_name, :artist_phonetic, presence: true

end
