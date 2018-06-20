class GenresController < ApplicationController
  def show
  	@genre = Genre.find(params[:id])
  	@products = @genre.product
  	@genres = Genre.all
  end
end
