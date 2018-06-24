class GenresController < ApplicationController
  def show
  	@genre = Genre.find(params[:id])
  	@products = @genre.product.where(genre_id: @genre.id, delete_flag: false)
  	@page_products = @products.page(params[:page]).reverse_order
  	@genres = Genre.all
  end
end
