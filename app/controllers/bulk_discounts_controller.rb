class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @new_discount = @merchant.bulk_discounts.new(discount_params)

    if @new_discount.save
      flash[:notice] = "Successfully Created #{@new_discount.id}"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash[:alert] = @new_discount.errors.full_messages.to_sentence
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    
    if discount.update(discount_params)
      flash[:notice] = "Successfully Updated #{discount.id}"
      redirect_to merchant_bulk_discount_path(merchant, discount)
    else
      redirect_to edit_merchant_bulk_discount_path(merchant, discount)
      flash[:alert] = discount.errors.full_messages.to_sentence
    end
  end

private
  def discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end