# frozen_string_literal: true

require_relative '../lib/item'
require_relative '../lib/checkout'
require_relative '../lib/discounts/bulk_discount'
require_relative '../lib/discounts/basket_discount'

def assert_equal(expected, actual, message = nil)
  if expected == actual
    puts "Passed: #{message}"
  else
    puts "Failed: #{message || "Expected #{expected}, but got #{actual}"}"
  end
end

def run_tests
  item_a = Item.new('A', 50)
  item_b = Item.new('B', 30)
  item_c = Item.new('C', 20)

  pricing_rules = [
    BulkDiscount.new('A', 2, 90),
    BulkDiscount.new('B', 3, 75),
    BasketDiscount.new(200, 10)
  ]

  # Case 1: Discounts shouldn't be applied
  checkout = Checkout.new(pricing_rules)
  checkout.scan(item_a)
  checkout.scan(item_b)
  checkout.scan(item_c)
  assert_equal(100, checkout.total,
               'Test 1: A, B, C scanned with no discounts applied (Total: £100)')

  # Case 2: Bulk discounts should be applied
  checkout = Checkout.new(pricing_rules)
  checkout.scan(item_b)
  checkout.scan(item_a)
  checkout.scan(item_b)
  checkout.scan(item_b)
  checkout.scan(item_a)
  assert_equal(165, checkout.total,
               "Test 2: 2 A's (bulk discount £90 for 2), 3 B's (bulk discount £75 for 3) (Total: £165)")

  # Case 2: Bulk discounts and basket discounts should be applied
  checkout = Checkout.new(pricing_rules)
  checkout.scan(item_c)
  checkout.scan(item_b)
  checkout.scan(item_a)
  checkout.scan(item_a)
  checkout.scan(item_c)
  checkout.scan(item_b)
  checkout.scan(item_c)
  assert_equal(189, checkout.total,
               "Test 3: 2 A's (bulk discount £90 for 2), 2 B's (£60 for 2), 3 C's (£20 each), Total over £200 (10% discount applied) (Total: £189)")
end
