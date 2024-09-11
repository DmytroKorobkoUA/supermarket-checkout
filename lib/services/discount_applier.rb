# frozen_string_literal: true

class DiscountApplier
  def initialize(discounts)
    @discounts = discounts
  end

  def apply_bulk_discounts(items)
    bulk_discounts = @discounts.select { |discount| discount.is_a?(BulkDiscount) }
    bulk_discounts.sum { |discount| discount.apply(items) }
  end

  def apply_basket_discounts(total)
    basket_discounts = @discounts.select { |discount| discount.is_a?(BasketDiscount) }
    basket_discounts.sum { |discount| discount.apply(total) }
  end
end
