class DiscsController < ApplicationController
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

	private
	def disc_params
      params.require(:disc).permit(tunes_attributes: [:id, :tune_name, :tune_number, :artist_id, :disc_id,  :_destroy])
    end
end
