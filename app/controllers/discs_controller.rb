class DiscsController < ApplicationController
	   before_action :access_admin, only:[:show, :edit]

	def show
		@disc = Disc.find(params[:id])
	end

	def edit
		@disc = Disc.find(params[:id])
		@artists = Artist.all

	end

	def update
		@disc = Disc.find(params[:id])
		@disc.update(disc_params)
		redirect_to disc_path(@disc.id)
	end

	def create
		product = Product.find(params[:product_id])
		discs = Disc.where(product_id: product.id)
		disc = discs.last
		Disc.create(product_id: product.id, disc_number: disc.disc_number + 1)
		redirect_to edit_product_path(product)
	end

	def destroy
		disc = Disc.find(params[:id])
		product = Product.find(params[:product_id])
		disc.destroy
		redirect_to edit_product_path(product)
	end


	private
	def disc_params
      params.require(:disc).permit(tunes_attributes: [:id, :tune_name, :tune_number, :artist_id, :disc_id,  :_destroy])
  end
	def access_admin
		unless   admin_signed_in?
			redirect_to("/")
		end
  end
end
