class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def price_formatter(price)
    "%.2f" % (price / 100)
  end
end
