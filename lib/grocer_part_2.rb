require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0 
  
  while counter < coupons.length 
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else 
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num], 
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
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
  clearance_cart = cart.each do |grocery_item|
    #binding.pry 
    if grocery_item[:clearance] == true
      new_price = (grocery_item[:price] * 0.8).round(2)
      grocery_item[:price] = new_price
    end 
    #binding.pry 
  end
 #binding.pry
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated_cart = consolidate_cart(cart)
  after_coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(after_coupon_cart)
  #binding.pry 
  
  final_price_array = []
  
  clearance_cart.each do |cart_item|
    final_price_array << cart_item[:price] * cart_item[:count]
    #binding.pry
  end 
  
  final_price = final_price_array.reduce(:+)
  
  if final_price > 100
    final_price = (final_price * 0.90).round(2)
  end 
  #binding.pry
  
  final_price 
end
