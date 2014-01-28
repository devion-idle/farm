# Financial Variables
money = 50
profit = 60
expenses = 20
net = 40
wage_farmer = 6
wage_driver = 8
wage_tiller = 6

# Update profit
update_profit = ->
  time = Math.max(potato.time_harvest_max, potato.time_shipping_max)
  profit = potato.val_crop*potato.num_acres*60/time
  expenses = potato.num_farmers*wage_farmer + potato.num_drivers_max*wage_driver + 
    +num_tillers*wage_tiller + potato.val_seed*potato.num_acres*60/time
  net = profit - expenses

# Update money
update_money = ->
  money -= (potato.num_farmers*wage_farmer + potato.num_drivers_max*wage_driver)/60
  
# Update financial text
update_financial_text = ->
  $('#money').text("$#{money.toFixed(2)}")
  $('#profit').text("$#{profit.toFixed(2)}/min")
  $('#expenses').text("$#{expenses.toFixed(2)}/min")
  $('#net').text("$#{net.toFixed(2)}/min")