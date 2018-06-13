class TunesController < ApplicationController
	def new
	  	@disc = Disc.find(params[:disc_id])
	  	@artists = Artist.all
	  	@tune = Tune.new
	    @tunes = Tune.where(disc_id: @disc.id)
	    @discs = Disc.where(product_id: @disc.product_id)
	end

	def create
	  	tune = Tune.new(tune_params)
	  	disc = Disc.find_by(id: params[:disc_id])
	  	if artist = Artist.find_by(artist_name: params[:tune][:artist_id])
	        tune.artist_id = artist.id
	      else
	        new_artist = Artist.create(artist_name: params[:tune][:artist_id])
	        tune.artist_id = new_artist.id
	      end
	    tune.disc_id = disc.id
	  	tune.save
	    redirect_to new_disc_tune_path(disc.id)
	end

	def destroy
	    tune = Tune.find(params[:id])
	    disc = Disc.find_by(id: params[:disc_id])
	    tune.destroy
	    redirect_to new_disc_tune_path(disc.id)
    end
	private
	    def tune_params
	    	params.require(:tune).permit(:tune_name, :disc_id, :artist_id, :tune_number, :id, :_destroy)
	    end
end
