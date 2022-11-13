class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  

  validates_presence_of :name
  validates_presence_of :percentage_discount
  validates_presence_of :threshold
  validates :percentage_discount, :threshold, :numericality => true
end