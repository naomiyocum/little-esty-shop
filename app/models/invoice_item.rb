class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
 
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true

  def self.uniq_invoice_items
    distinct
  end

  def discount_dollars
    (my_revenue * discount_calc).to_i
  end

  def my_revenue
    quantity * unit_price
  end

  def discount_calc
    best_discount.percentage_discount / 100.0
  end

  def best_discount
    item.merchant.bulk_discounts.max_discount(quantity)
  end
end
