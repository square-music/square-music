class ContactsController < ApplicationController

	def new
		@contact = Contact.new
	end

	def index
		@contact = Contact.all
		@user = User.find(params :user_id)
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
        params.require(:contact).permit(:user_id, :content, :type)
      end
      
end
