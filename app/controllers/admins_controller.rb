class AdminsController < ApplicationController
  private
    def user_params
        params.require(:admin).permit(:admin_name)
    end
end
