require_relative './part_1_solution.rb'

def coupon_hash_maker(current_item, current_coupons)
    discounted_item = {}
    current_item[:count] = current_item[:count] - current_coupons[:num] # might need to change if coupons exeeds items count
    discounted_item[:item] = current_item[:item] + " W/COUPON"

    discounted_item[:price] = (current_coupons[:cost] / current_coupons[:num])
    discounted_item[:clearance] = current_item[:clearance]
    discounted_item[:count] = current_coupons[:num]
    return discounted_item
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0

  while index < coupons.length do
    
    current_coupons = coupons[index]
    index_cart = 0
    
    while index_cart < cart.length do 
      current_item = cart[index_cart] 
      discounted_item = {} 
      #coup_conditon = current_item[:count] - current_coupons[:num]
      
      if current_coupons[:item] == current_item[:item] 
        coup_conditon = 0 <= current_item[:count] - current_coupons[:num]
        puts coup_conditon
        if coup_conditon
          discounted_item = coupon_hash_maker(current_item, current_coupons)
          
          puts"test"
          cart.push(discounted_item)
          puts"tes2"
        end
      end
      
      index_cart += 1
    end 
    index +=1
  end 

  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart.each do |item|
    
    if item[:clearance] == true
      item[:price] = item[:price] * 0.8
    end 
  end
  
  cart
  
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
  
  consolidatedCart = consolidate_cart(cart)

  couponsCart = apply_coupons(consolidatedCart,coupons)
  puts couponsCart
  cleared = apply_clearance(couponsCart)
  
  total = 0
  cleared.each do |item|
    cost = item[:price] * item[:count]
    total += cost
  end 
  
  if total > 100 
    total = total * 0.9
  end 
  
  total.round(2)
end
