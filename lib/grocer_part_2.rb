require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  counter = 0 
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] - coupons[counter][:num]
      else
        cart_item_with_coupon = {
          item: couponed_item_name, 
          price: coupons[counter][:cost] / coupons[counter][:num],
          clearance: cart_item[:clearance],
          count: coupons[counter][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length
    if cart[counter][:clearance] == true
      cart[counter][:price] = cart[counter][:price] - (cart[counter][:price] * 0.2).round(2)
    end
    counter += 1
  end
  cart
end

def checkout(cart, coupons)
  total = []
  new_cart = consolidate_cart(cart)
  new_cart_with_coupons = apply_coupons(new_cart, coupons)
  new_cart_with_coupons_and_clearance = apply_clearance(new_cart_with_coupons)
  
  new_cart_with_coupons_and_clearance.each do |item|
    total << item[:price] * item[:count]
  end
  
  total.sum > 100 ? (total.sum - (total.sum * 0.1)) : total.sum
end









