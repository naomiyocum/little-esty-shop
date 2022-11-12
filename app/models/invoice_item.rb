class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
 
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true

  def self.uniq_invoice_items
    distinct
  end

  def self.qualified_invoice_items
    joins(item: [merchant: :bulk_discounts])
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .group('invoice_items.id')
  end

  def self.all_discounts

  end


  def available_discount
    self.item.merchant.bulk_discounts.max_discount(self.quantity)
  end
end
