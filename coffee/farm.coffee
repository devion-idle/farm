# Financial Variables
money = 50
profit = 60
expenses = 20
net = 40
wage_farmer = 6
wage_driver = 8

# Potato Variables
class Crop
  constructor: (@val_seed, @val_crop) ->
    @num_farmers = 0
    @num_acres = 0
    @num_harvested = 0
    @num_drivers = 0
    @num_drivers_max = 0
    @num_shipping = 0
    @time_harvest = 0
    @time_harvest_max = 0
    @time_shipping = 0
    @time_shipping_max = 0

# Update timing
update_timing = ->
  potato.time_harvest_max = potato.num_acres/(potato.num_farmers*0.2)
  potato.time_harvest = (potato.num_acres - potato.num_harvested)/(
    potato.num_farmers*0.2)
  
    
# Update profit
update_profit = ->
  time = Math.max(potato.time_harvest_max, potato.time_shipping_max)
  profit = potato.val_crop*potato.num_acres*60/time
  expenses = potato.num_farmers*wage_farmer + potato.num_drivers_max*wage_driver + 
    potato.val_seed*potato.num_acres*60/time
  net = profit - expenses
    
# Update text
update_text = ->
  # Update financial text
  $('#money').text("$#{money.toFixed(2)}")
  $('#profit').text("$#{profit.toFixed(2)}/min")
  $('#expenses').text("$#{expenses.toFixed(2)}/min")
  $('#net').text("$#{net.toFixed(2)}/min")
  
  # Update potato text
  $('.potato #num_farmers').text(potato.num_farmers)
  $('.potato #num_acres').text(potato.num_acres)
  $('.potato #num_harvested').text(Math.floor(potato.num_harvested))
  $('.potato #time_harvest').text(
    "#{Math.ceil(potato.time_harvest)} (#{Math.ceil(potato.time_harvest_max)}) sec")
  $('.potato #num_drivers').text("#{potato.num_drivers}/#{potato.num_drivers_max}")
  $('.potato #time_shipping').text(
    "#{Math.ceil(potato.time_shipping)} (#{Math.ceil(potato.time_shipping_max)}) sec")


    
# Timer function, called every 1 second
timer_step = ->
  # Update potato harvested
  potato.num_harvested = Math.min(potato.num_acres, 
    potato.num_harvested + potato.num_farmers*0.2) # 5 seconds/potato/farmer    
  potato.time_harvest-- if potato.time_harvest > 0
  
  # Start potato shipping
  # TODO: Shipping time on log scale
  if potato.num_harvested >= potato.num_acres and potato.num_drivers > 0
    potato.num_shipping = potato.num_harvested
    potato.num_harvested = 0
    money -= potato.val_seed*potato.num_acres
    potato.num_drivers--
    potato.time_shipping = potato.time_shipping_max
    potato.time_harvest = potato.time_harvest_max
  
  # End potato shipping
  if potato.time_shipping > 0 
    potato.time_shipping-- 
    if potato.time_shipping <= 0
      money += potato.val_crop*potato.num_shipping
      potato.num_shipping = 0
      potato.num_drivers++
  
  money -= (potato.num_farmers*wage_farmer + potato.num_drivers_max*wage_driver)/60
  
  # Update
  update_text()

  
  
# Initialization
potato = new Crop(0.50, 5)
potato.num_farmers = 1
potato.num_acres = 10
potato.num_drivers_max = 1
potato.num_drivers = 1
potato.time_harvest = 50
potato.time_harvest_max = 50
potato.time_shipping_max = 20
update_text()
$(document).ready( -> setInterval(timer_step, 1000) )


# === Store ===

# Farmer
$('#hire_farmer').button().click( -> 
  potato.num_farmers++
  update_timing()
  update_profit()
  update_text())
$('#fire_farmer').button().click( -> 
  potato.num_farmers-- if potato.num_farmers > 1
  update_timing()
  update_profit()
  update_text())
  
# Driver
$('#hire_driver').button().click( -> 
  potato.num_drivers++
  potato.num_drivers_max++
  update_timing()
  update_profit()
  update_text())
$('#fire_driver').button().click( -> 
  if potato.num_drivers > 1
    potato.num_drivers--
    potato.num_drivers_max--
  update_timing()
  update_profit()
  update_text())
