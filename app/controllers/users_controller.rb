class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  
  def show
  	@user = User.find(params[:id])
  end

  private
    def user_params
        params.require(:user).permit(:user_name, :user_phonetic, :postal, :address, :tell, :emal)
    end

end
