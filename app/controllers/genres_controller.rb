class GenresController < ApplicationController
  def show
  	@genre = Genre.find(params[:id])
  	@products = @genre.product
  	@page_products = @products.page(params[:page]).reverse_order
  	@genres = Genre.all
  end
end
