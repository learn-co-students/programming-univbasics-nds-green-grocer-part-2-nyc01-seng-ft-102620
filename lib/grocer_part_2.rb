require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  applied_coupons = []
  
  coupons.each do |coupon|
    item = find_item_by_name_in_collection(coupon[:item], cart)
    item_with_coupon = "#{coupon[:item]} W/COUPON"
    item_has_coupon = find_item_by_name_in_collection(item_with_coupon, cart)
      if item && item[:count] >= coupon[:num]
        if item_has_coupon
          item_has_coupon[:count] += coupon[:num]
          item[:count] -= coupon[:num]
        else
          item_has_coupon ={
            :item => item_with_coupon,
            :price => coupon[:cost] / coupon[:num],
            :count => coupon[:num],
            :clearance => item[:clearance]
          }
        cart << item_has_coupon
        item[:count] -= coupon[:num]
        end
      end  
  end
cart  
end  

def apply_clearance(cart)
clearanced_items = []  
 cart.each do |clearance_items|
  if clearance_items[:clearance]
    clearance_items[:price] = (clearance_items[:price] * 0.80).round(2)
  end
  clearanced_items << clearance_items
end
clearanced_items
end

def checkout(cart, coupons)

consolidated_cart = consolidate_cart(cart)
cart_with_coupons = apply_coupons(consolidated_cart, coupons)
clearanced_cart =  apply_clearance(cart_with_coupons)

total = 0
clearanced_cart.each do |get_total|
total += get_total[:price] * get_total[:count]
end
  
  if total > 100.00
    total = (total * 0.9).round(2)
  end
total  
end