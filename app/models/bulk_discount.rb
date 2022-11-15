class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage_discount, :quantity_threshold, :presence => true
  validates :percentage_discount, :numericality => { :less_than_or_equal_to => 100 }
  validates :quantity_threshold, :numericality => { :greater_than_or_equal_to => 1}

  def self.max_discount(quantity)
    where("quantity_threshold <= ?", quantity)
      .order(percentage_discount: :desc)
      .first
  end
end