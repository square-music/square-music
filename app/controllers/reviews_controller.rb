class ReviewsController < ApplicationController
	
	def create
	   product = Product.find(params[:product_id])
       comment = current_user.reviews.new(review_params)
       comment.product_id = product.id
        if comment.save
       redirect_to product_path(product)
       else
       	 redirect_to product_path(product)
       	flash[:danger] = '文字数が少なすぎます'
       end
	end

	def destroy
		product = Product.find(params[:product_id])
		# comment = product.review_id
		review = Review.find(params[:id])
		# binding.pry
		review.destroy
		redirect_to product_path(product)
	end

	private
	def review_params
    params.require(:review).permit(:user_id,:product_id,:comment)
    end

end
