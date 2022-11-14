class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :status, :presence => true
  validates :quantity, :unit_price, :numericality => true

  def self.uniq_invoice_items
    distinct
  end

  def applied_discount
    self.bulk_discounts.where("threshold <=  ?", quantity)
                        .order(bulk_discounts: :desc).first
  end
end
