class TunesController < ApplicationController
	before_action :access_admin, only: [:new]
	def new
	  	@disc = Disc.find(params[:disc_id])
	  	@product = Product.find_by(id: @disc.product_id)
	  	@artists = Artist.all
	  	@artist = Artist.find_by(id: @product.artist_id)
	  	@tune = Tune.new
	    @tunes = Tune.where(disc_id: @disc.id).order('tune_number')
	    @last_tune =Tune.where(disc_id: @disc.id).order('tune_number').last
	    @discs = Disc.where(product_id: @disc.product_id)

	end

	def create
	  	tune = Tune.new(tune_params)
	  	disc = Disc.find_by(id: params[:disc_id])
	  	tunes = Tune.where(disc_id: disc.id)
	  	tunes.each do |t|
	  		if t.tune_number == tune.tune_number
	  			flash[:warning] = 'その曲順はすでに登録されています。'
	  			redirect_to new_disc_tune_path(disc.id)
	  			return
	  		end
	  	end

	  	if artist = Artist.find_by(artist_name: params[:artist][:artist_name])
	        tune.artist_id = artist.id
	      else
	        new_artist = Artist.create(artist_name: params[:artist][:artist_name], artist_phonetic: params[:artist][:artist_phonetic])
	        tune.artist_id = new_artist.id
	      end
	    tune.disc_id = disc.id
	    if tune.save
	    	redirect_to new_disc_tune_path(disc.id)
	    	flash[:success] = '曲を登録しました！'
	    	return
	    else
	    	redirect_to new_disc_tune_path(disc.id)
	    	return
	    end
	end

	def destroy
	    tune = Tune.find(params[:id])
	    disc = Disc.find_by(id: params[:disc_id])
	    tune.destroy
	    redirect_to new_disc_tune_path(disc.id)
    end
		def access_admin
      unless   admin_signed_in?
        redirect_to("/")
      end
  end
	private
		def tune_params
	    	params.require(:tune).permit(:tune_name, :tune_number, :artist_name, :artist_phonetic)
	 	end
end
