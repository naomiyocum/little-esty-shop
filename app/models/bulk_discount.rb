class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage_discount, :quantity_threshold, :presence => true
  validates :percentage_discount, :quantity_threshold, :numericality => true
end