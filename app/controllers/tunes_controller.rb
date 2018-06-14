class TunesController < ApplicationController
	def new
	  	@disc = Disc.find(params[:disc_id])
	  	product = Product.find_by(id: @disc.product_id)
	  	@artists = Artist.all
	  	@artist = Artist.find_by(id: product.artist_id)
	  	@tune = Tune.new
	    @tunes = Tune.where(disc_id: @disc.id).order('tune_number')
	    @discs = Disc.where(product_id: @disc.product_id)
	end

	def create
	  	tune = Tune.new(tune_name: params[:tune_name], tune_number: params[:tune_number])
	  	disc = Disc.find_by(id: params[:disc_id])
	  	if artist = Artist.find_by(artist_name: params[:artist_name])
	        tune.artist_id = artist.id
	      else
	        new_artist = Artist.create(artist_name: params[:artist_name], artist_phonetic: params[:artist_phonetic])
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
	    	params.permit(:tune_name, :tune_number, :artist_name, :artist_phonetic)
	    end
end
