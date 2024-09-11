# frozen_string_literal: true

# Just run: ruby main.rb from your terminal for seeing results

require_relative 'lib/item'
require_relative 'lib/checkout'
require_relative 'lib/discounts/bulk_discount'
require_relative 'lib/discounts/basket_discount'
require_relative 'test/checkout_test'

item_a = Item.new('A', 50)
item_b = Item.new('B', 30)
item_c = Item.new('C', 20)

discounts = [
  BulkDiscount.new('A', 2, 90),
  BulkDiscount.new('B', 3, 75),
  BasketDiscount.new(200, 10)
]

checkout = Checkout.new(discounts)
checkout.scan(item_a)
checkout.scan(item_b)
checkout.scan(item_c)

example_output = <<~OUTPUT
  Example Calculation:
  Items scanned: A (£50), B (£30), C (£20)
  Total price for A, B, C without discounts: £#{item_a.price + item_b.price + item_c.price}
  Applying discounts...
  Final total price after discounts: £#{checkout.total}
  ---------------------------------------
OUTPUT

puts example_output

# Testing below
def run_all_tests
  puts 'Test results:'

  run_tests
end

run_all_tests if __FILE__ == $PROGRAM_NAME
