class Transaction < ApplicationRecord
  belongs_to :invoice
  
  validates :credit_card_number, :result, :presence => true
  validates_numericality_of :credit_card_number
  validates_presence_of :result
end
