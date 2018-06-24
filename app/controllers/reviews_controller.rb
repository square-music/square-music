class ReviewsController < ApplicationController

	def create
		product = Product.find(params[:product_id])
		user = current_user
		review = Review.new(review_params)
		review.user_id = user.id
		review.product_id = product.id
		review.star = params[:star]
			if review.save
			redirect_to product_path(product)
			else
			redirect_to product_path(product)
			flash[:danger] = '☆の入力をしていないか、2文字以下のコメントはできません！'
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
	params.require(:review).permit(:user_id,:product_id,:comment,:star)
	end

end
