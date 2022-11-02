class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
 
  def transaction_count
    self.transactions.count
  end
end
