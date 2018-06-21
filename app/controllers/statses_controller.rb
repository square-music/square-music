class StatsesController < ApplicationController

    def update
       status = Status.find_by(:shipment_status params[:status][:shipment_status])
       status.update(status_params)
       redirect_to user_order_path(@user)
    end
    
    private
    def status_params
	    params.require(:status).permit(:shipment_status)
	  end

end
