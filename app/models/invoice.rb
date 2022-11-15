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

  def my_total_revenue_formatter(merchant)
    "%.2f" % (my_total_revenue(merchant).to_f / 100).round(2)
  end

  
  def admin_total_revenue(invoice_name)
    invoice_items.joins(:invoice)
    .where(invoice_items: {invoice_id: self.id})
    .where(invoices: {id: invoice_name.id})
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end
  
  def admin_revenue_formatter(invoice_name)
    "%.2f" % (admin_total_revenue(invoice_name).to_f / 100).round(2)
  end

  def self.incomplete_invoices
    joins(:invoice_items).where("invoice_items.status != ?", 2).distinct.order(:created_at)
  end

  def total_discount
    invoice_items.joins(:bulk_discounts)
                  .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage_discount / 100.0)) as total_discount')
                  .where('invoice_items.quantity >= bulk_discounts.threshold')
                  .group('invoice_items.id')
                  .order(total_discount: :desc)
                  .sum(&:total_discount)
  end

  def discount_format
    ((self.total_discount.to_f / 100).round(2))
  end
end
