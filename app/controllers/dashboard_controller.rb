class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five = @merchant.customers.top_five_customers
    @items_ready_to_ship = @merchant.not_yet_shipped
  end
end