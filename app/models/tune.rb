class Tune < ApplicationRecord
	belongs_to :artist
	belongs_to :disc
	validates :disc_id, :artist_id, :tune_name, :tune_number, presence: true
	validates :tune_number, :numericality => {:greater_than_or_equal_to => 1}

end
