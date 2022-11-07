class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum status: ["in progress", "cancelled", "completed"]

  def self.uniq_invoices
    distinct
  end

  def my_total_revenue(merchant)
    invoice_items.joins(:item)
      .where(invoice_items: {invoice_id: self.id})
      .where(items: {merchant_id: merchant.id})
      .sum('invoice_items.unit_price * invoice_items.quantity')
    end
    
    def admin_total_revenue(invoice_name)
      invoice_items.joins(:invoice)
      .where(invoice_items: {invoice_id: self.id})
      .where(invoices: {id: invoice_name.id})
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end

