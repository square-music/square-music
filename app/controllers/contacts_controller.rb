class ContactsController < ApplicationController

	def new
		@contact = Contact.new
	end

	def index
		@contacts = Contact.all.reverse_order
		@user = User.find(params :user_id)
	end

	def create
		contact = Contact.new(contact_params)
		contact.user_id = current_user.id
		 if contact.save
		redirect_to root_path
		 flash[:success] = "問い合わせ情報を送信しました"
		else
		redirect_to new_contact_path
		flash[:danger] = "内容を記入してください。"
		end
	end

	def destroy
		contact = Contact.find(params[:id])
		contact.destroy
		redirect_to contacts_path
	end

	def about
	end

	def question
	end

	def contact_params
        params.require(:contact).permit(:user_id, :content, :type)
      end
      
end
