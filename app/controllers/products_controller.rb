class ProductsController < ApplicationController
	before_action :access_admin, only: [:new, :edit, :index]

	def index
	   @products = Product.all
	end

    def new
	    @artists = Artist.all
	    @labels = Label.all
	    @genres = Genre.all
	    @product = Product.new
	    @artist = Artist.new
	    @label = Label.new
	    @genre = Genre.new
	end

    def create
	    product = Product.new(product_params)
	    	if artist = Artist.find_by(artist_name:  params[:artist][:artist_name])
	    		product.artist_id = artist.id
	   		else
	    		new_artist = Artist.create(artist_name:  params[:artist][:artist_name], artist_phonetic: params[:artist][:artist_phonetic])
	    		product.artist_id = new_artist.id
	    	end
	    	if label = Label.find_by(label_name: params[:label][:label_name])
	        	product.label_id = label.id
	        else
	       		new_label = Label.create(label_name: params[:label][:label_name])
	        	product.label_id = new_label.id
	        end
	        if genre = Genre.find_by(genre_name: params[:genre][:genre_name])
	        	product.genre_id = genre.id
	        else
	        	new_genre = Genre.create(genre_name: params[:genre][:genre_name])
	        	product.genre_id = new_genre.id
	        end
	    product.save
	    i = 1
	    while i <= product.disc_amount
	      disc = Disc.create(product_id: product.id, disc_number: i)
	      i += 1
	    end
	    disc = Disc.find_by(product_id: product.id, disc_number: 1)
	    redirect_to new_disc_tune_path(disc)
	end

	def edit
		@product = Product.find(params[:id])
		@artists = Artist.all
	    @labels = Label.all
	    @genres = Genre.all
	    @discs = Disc.where(product_id: @product.id)
	    @artist = Artist.find(@product.artist_id)
	    @label = Label.find(@product.label_id)
	    @genre = Genre.find(@product.genre_id)
    end

	def update
		product = Product.find(params[:id])
		if artist = Artist.find_by(artist_name:  params[:artist][:artist_name])
	    		product.artist_id = artist.id
	   		else
	    		new_artist = Artist.create(artist_name:  params[:artist][:artist_name], artist_phonetic: params[:artist][:artist_phonetic])
	    		product.artist_id = new_artist.id
	    	end
	    	if label = Label.find_by(label_name: params[:label][:label_name])
	        	product.label_id = label.id
	        else
	       		new_label = Label.create(label_name: params[:label][:label_name])
	        	product.label_id = new_label.id
	        end
	        if genre = Genre.find_by(genre_name: params[:genre][:genre_name])
	        	product.genre_id = genre.id
	        else
	        	new_genre = Genre.create(genre_name: params[:genre][:genre_name])
	        	product.genre_id = new_genre.id
	        end
		product.update(product_params)
		redirect_to edit_product_path(product)
	end

	def destroy
		product = Product.find(params[:id])
		product.destroy
		redirect_to products_path
	end

	def top
		@genres = Genre.all
		@same_genre = Product.all
	end

	def search
		@search = Product.ransack(params[:q])
		@products = @search.result
		@search_products = @products.page(params[:page]).reverse_order
		@q = Product.ransack(params[:q])
		@genres = Genre.all
	end

	def show
		@product = Product.find(params[:id])
		@same_genre = Product.where(genre_id: @product.genre_id)
		if @same_genre.length<=2 then
			@same_genre = Product.all
		end
		@same_genre = @same_genre.where.not(id: params[:id])
		@review = Review.new
		@cart_item = CartItem.new
		@genres = Genre.all
	end
	def access_admin
		unless   admin_signed_in?
			redirect_to("/")
		end
  end
	private
	  def product_params
	    params.require(:product).permit(:product_name, :product_phonetic, :product_price, :disc_amount, :release, :stock, :image, :description, :artist_id, :label_id, :genre_id)
	  end


end
