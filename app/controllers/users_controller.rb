class UsersController < ApplicationController
  before_action :access_authority, only: [:show,:edit]
  before_action :access_admin, only: [:index]

  layout "special_layout", only: [:index]

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザ情報を編集しました"
       user_path(@user.id)
    else
       render "users/edit"
    end
  end
  def show
  	@user = User.find(params[:id])
    @unsubscribe_comment = UnsubscribeComment.find_by(user_id: params[:id])
    @orders = Order.where(user_id: params[:id]).page(params[:page]).per(10).order(created_at: :desc)
  end
  def completion
    unless cart = Cart.find_by(user_id: current_user.id)
      Cart.create(user_id: current_user.id)
    end
  end
  def index
    @users = User.all
    @search = User.ransack(params[:q])
    @users = @search.result.page(params[:page])
  end
  def soft_delete
    @user = User.find(params[:id])
    @user.update(delete_flag: "true")
    redirect_to user_path(@user.id)
  end
  def restoration
    @user = User.find(params[:id])
    @user.update(delete_flag: "false")
    redirect_to user_path(@user.id)
  end
  private
    def user_params
        params.require(:user).permit(:user_name, :user_phonetic, :postal, :address, :tell, :email)
    end
    def access_authority
      unless   admin_signed_in? ||  user_signed_in? && current_user.id == params[:id].to_i
        redirect_to user_session_path
      end
    end
    def access_admin
        unless   admin_signed_in?
          redirect_to("/")
        end
    end
end
