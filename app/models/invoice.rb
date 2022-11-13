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

  def my_total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.incomplete_invoices
    joins(:invoice_items).where("invoice_items.status != ?", 2).distinct.order(:created_at)
  end

  def qualified_invoice_items
    invoice_items.joins(item: [merchant: :bulk_discounts])
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .group('invoice_items.id')
  end

  def all_discounts
    qualified_invoice_items.sum {|invoice_item| invoice_item.discount_dollars}
  end

  def discounted_revenue
    my_total_revenue - all_discounts
  end
end
