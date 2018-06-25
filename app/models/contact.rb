class Contact < ApplicationRecord

	validates :type, :content, presence: true

	belongs_to :user
	self.inheritance_column = :_type_disabled

end
