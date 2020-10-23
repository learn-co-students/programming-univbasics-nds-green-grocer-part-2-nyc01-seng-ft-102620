require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  coupon_cart= []
  cart.each do |item_hash|
    discount_item = find_item_by_name_in_collection(item_hash[:item], coupons)
    if discount_item && discount_item[:num] <= item_hash[:count]
      discount_item[:count] = discount_item[:num]
      discount_item[:item] = "#{discount_item[:item]} W/COUPON"
      discount_item[:price] = (discount_item[:cost] / discount_item[:num])
      discount_item[:clearance] = item_hash[:clearance]
      item_hash[:count] = item_hash[:count] - discount_item[:count]
      coupon_cart << item_hash
      coupon_cart << discount_item
    else
      coupon_cart << item_hash
   end
  end
  return coupon_cart
end


def apply_clearance(cart)
 cart.collect do |item_hash|
     if item_hash[:clearance]
       item_hash[:price] = (item_hash[:price] - (item_hash[:price] * 0.2))
     end
   end
 cart
end

def checkout(cart, coupons)
  con_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(con_cart, coupons)
  final_cart = apply_clearance(coup_cart)
  item_prices = []
  final_cart.each do |item|
    item_prices << (item[:price] * item[:count])
  end
  subtotal = item_prices.sum
  if subtotal > 100
     total = subtotal - (subtotal * 0.1)
  else
    total = subtotal
  end
  return total
end
