# frozen_string_literal: true

require_relative '../discount'

class BasketDiscount < Discount
  def initialize(minimum_total, discount_percentage)
    super()
    @minimum_total = minimum_total
    @discount_percentage = discount_percentage
  end

  def apply(total)
    total > @minimum_total ? total * (@discount_percentage / 100.0) : 0
  end
end
