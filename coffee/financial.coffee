# Financial global variables
money = 50
profit = 0
expenses = 0
net = 0
wage_farmer = 6
wage_driver = 8
wage_tiller = 6

# Update profit
update_profit = ->
  if potato.num_drivers_needed <= num_drivers_max
    num_potatoes = potato.num_acres*60/potato.time_harvest_max
  else
    num_potatoes = potato.num_acres*60*num_drivers_max/potato.time_shipping_max
  
  profit = num_potatoes*potato.val_crop
  expenses = potato.num_farmers*wage_farmer + num_drivers_max*wage_driver + 
    + num_tillers*wage_tiller + num_potatoes*potato.val_seed
  net = profit - expenses

# Update money
update_money = ->
  money -= (potato.num_farmers*wage_farmer + num_drivers_max*wage_driver + 
    num_tillers*wage_tiller)/60
  
# Update financial text
update_financial_text = ->
  $('#money').text("$#{money.toFixed(2)}")
  $('#profit').text("$#{profit.toFixed(2)}/min")
  $('#expenses').text("$#{expenses.toFixed(2)}/min")
  $('#net').text("$#{net.toFixed(2)}/min")