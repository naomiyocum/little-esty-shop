class AdminController < ApplicationController
  def index
     @invoices = Invoice.incomplete_invoices
  end
end
