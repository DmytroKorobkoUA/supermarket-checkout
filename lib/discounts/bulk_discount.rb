# frozen_string_literal: true

require_relative '../discount'

class BulkDiscount < Discount
  def initialize(item_name, required_quantity, discounted_price)
    super()
    @item_name = item_name
    @required_quantity = required_quantity
    @discounted_price = discounted_price
  end

  def apply(items)
    applicable_items = items.select { |item| item.name == @item_name }
    count = applicable_items.size
    discount_sets = count / @required_quantity

    original_price = applicable_items.first.price * @required_quantity
    discount_sets * (original_price - @discounted_price)
  end
end
