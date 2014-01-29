# Update text
update_text = ->
  update_financial_text()
  update_land_text()
  update_industry_text()
  potato.update_crop_text()
  
# Timer function, called every 1 second
timer_step = ->
  potato.update_crop()  
  update_money()
  update_land()
  update_shipments()
  update_text()
  
# Initialization
update_profit()
update_money()
update_land()
update_shipments()
update_text()
$(document).ready( -> setInterval(timer_step, 1000) )