class BulkDiscountsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    # @bulk_discounts = BulkDiscount.find(params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = merchant.bulk_discounts
    # require 'pry'; binding.pry
    # @bulk_discounts = 
  end
end