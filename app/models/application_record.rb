class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def price_formatter(price)
    price.to_f / 100
  end
end
