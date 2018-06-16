class ProductsController < ApplicationController
	def index
	   @products = Product.all
	end

    def new
	    @artists = Artist.all
	    @labels = Label.all
	    @genres = Genre.all
	    @product = Product.new
	end

    def create
	    @product = Product.new(product_name: params[:product_name],
    						   product_phonetic: params[:product_phonetic],
    						   product_price: params[:product_price],
    						   disc_amount: params[:disc_amount],
    						   release: params[:release],
    						   stock: params[:stock],
    						   description: params[:description],
    						   image_id: params[:image_id])


	    	if artist = Artist.find_by(artist_name: params[:artist_name])
	    		@product.artist_id = artist.id
	   		else
	    		new_artist = Artist.create(artist_name: params[:artist_name], artist_phonetic: params[:artist_phonetic])
	    		@product.artist_id = new_artist.id
	    	end
	    	if label = Label.find_by(label_name: params[:label_name])
	        	@product.label_id = label.id
	        else
	       		new_label = Label.create(label_name: params[:label_name])
	        	@product.label_id = new_label.id
	        end
	        if genre = Genre.find_by(genre_name: params[:genre_name])
	        	@product.genre_id = genre.id
	        else
	        	new_genre = Genre.create(genre_name: params[:genre_name])
	        	@product.genre_id = new_genre.id
	        end
	    @product.save
	    i = 1
	    while i <= @product.disc_amount
	      disc = Disc.create(product_id: @product.id, disc_number: i)
	      i += 1
	    end
	    disc = Disc.find_by(product_id: @product.id, disc_number: 1)
	    redirect_to new_disc_tune_path(disc)
	end

	def edit
    end

	def update
	end

	def destroy
		product = Product.find(params[:id])
		product.destroy
		redirect_to products_path
	end

	def top
	end

	def search
	end

	def show
		@product = Product.find(params[:id])
		@review = Review.new
	end

	private
	  def product_params
	    params.permit(:product_name, :product_phonetic, :artist_name, :artist_phonetic, :label_name, :genre_name, :product_price, :disc_amount, :release, :stock, :image_id, :description)
	  end

end
