class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
 
  validates :first_name, :last_name, :presence => true
  
  def transaction_count
    self.transactions.count
  end

  def self.top_five_customers
    select("customers.*, count(transactions.*) AS transaction_count")
      .joins(invoices: :transactions)
      .where('transactions.result = ?', 'success')
      .group('customers.id')
      .order('transaction_count DESC')
      .limit(5)
  end
end
