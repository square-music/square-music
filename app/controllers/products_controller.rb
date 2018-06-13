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
	    @product = Product.new(product_params)
	      if artist = Artist.find_by(artist_name: params[:product][:artist_id])
	        @product.artist_id = artist.id
	      else
	        new_artist = Artist.create(artist_name: params[:product][:artist_id])
	        @product.artist_id = new_artist.id
	      end
	      if label = Label.find_by(label_name: params[:product][:label_id])
	        @product.label_id = label.id
	      else
	        new_label = Label.create(label_name: params[:product][:label_id])
	        @product.label_id = new_label.id
	      end
	      if genre = Genre.find_by(genre_name: params[:product][:genre_id])
	        @product.genre_id = genre.id
	      else
	        new_genre = Genre.create(genre_name: params[:product][:genre_id])
	        @product.genre_id = new_genre.id
	      end
	    @product.save
	    i = 1
	    while i <= @product.disc_amount
	      disc = Disc.create(product_id: @product.id, disc_number: i)
	      i += 1
	    end
	    disc = Disc.find_by(product_id: @product.id, disc_number: 1)
	    redirect_to edit_disc_path(disc)
	end

	def edit
    end

	def update
	end

	def destroy
	end

	def top
	end

	def search
	end

	def show
	end

	private
	  def product_params
	    params.require(:product).permit(:product_name, :product_phonetic, :product_price, :stock, :description, :release, :disc_amount, :artist_id, :label_id, :genre_id)
	  end

end
