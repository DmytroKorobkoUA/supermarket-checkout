# frozen_string_literal: true

require_relative 'item'
require_relative 'services/discount_applier'
require_relative 'discounts/basket_discount'
require_relative 'discounts/bulk_discount'

class Checkout
  def initialize(discounts = [])
    @items = []
    @discount_applier = DiscountApplier.new(discounts)
  end

  def scan(item)
    @items << item
  end

  def total
    total = @items.sum(&:price)

    return total if @discount_applier.nil?

    bulk_discount_amount = @discount_applier.apply_bulk_discounts(@items)
    total -= bulk_discount_amount

    basket_discount_amount = @discount_applier.apply_basket_discounts(total)
    total -= basket_discount_amount

    total
  end
end
