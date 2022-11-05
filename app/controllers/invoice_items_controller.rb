class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])

    invoice_item = InvoiceItem.where(invoice_id: invoice.id, item_id: params[:item_id]).first
    invoice_item.update(status: params[:status])

    redirect_to merchant_invoice_path(merchant, invoice)
  end
end