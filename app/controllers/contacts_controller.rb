class ContactsController < ApplicationController

	def new
		@contact = Contact.new
	end

	def index
		@contact = Contact.all
	end

	def create
		contact = Contact.ner(contact_params)
	end

	def destroy
	end

	def about
	end

	def question
	end

	def contact_params
        params.require(:contact).permit(:user_id, :order_number, :type)
      end
      
end
