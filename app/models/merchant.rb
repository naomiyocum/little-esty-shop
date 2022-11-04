class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum status: [:enabled, :disabled]

  validates_presence_of :name

  def not_yet_shipped
    invoice_items.joins(:invoice)
                 .where('invoice_items.status = 1')
                 .order('invoices.created_at')
                 .limit(5)
  end
end

