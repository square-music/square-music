class UsersController < ApplicationController
  def edit
    @user = User.find(1)
  end
  
end
