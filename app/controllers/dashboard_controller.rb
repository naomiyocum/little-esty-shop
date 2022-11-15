class DashboardController < ApplicationController
  def index
    if params[:search]
      @merchant = Merchant.find(params[:search])
      redirect_to merchant_dashboard_index_path(@merchant)
    else
      @merchant = Merchant.find(params[:merchant_id])
    end
  end
end