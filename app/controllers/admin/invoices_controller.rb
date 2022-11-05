class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoices = Invoice.all
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])

    invoice_item = InvoiceItem.where(invoice_id: invoice.id, item_id: params[:item_id]).first
    invoice_item.update(status: params[:status])

    redirect_to admin_invoice_path(invoice)
  end
end