class DashboardController < ApplicationController
  def index
    if params[:search]
      if Merchant.find_by(id: params[:search]) != nil
        @merchant = Merchant.find(params[:search])
        redirect_to merchant_dashboard_index_path(@merchant)
      else
        redirect_to root_path
        flash[:alert] = "Merchant ##{params[:search]} Does Not Exist"
      end
    else
      @merchant = Merchant.find(params[:merchant_id])
    end
  end
end