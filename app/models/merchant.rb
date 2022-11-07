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

  def self.top_five_merchants
    self.joins(:transactions)
        .where("invoices.status = 2", "transactions.results = success")
        .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .group(:id)
        .order("revenue desc").limit(5)
  end

  def merch_best_day
    invoices.select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
            .group('invoices.created_at')
            .order('revenue desc')
            .first
            .created_at.strftime('%m/%d/%Y')
  end
end
