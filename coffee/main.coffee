# Update text
update_text = ->
  update_financial_text()
  update_land_text()
  update_industry_text()
  update_motivate_text()
  potato.update_crop_text()
  
# Timer function, called every 1 second
timer_step = ->
  potato.update_crop()  
  update_money()
  update_land()
  update_shipments()
  update_text()
  update_motivate()
  
# Initialization
potato.update_crop_timing()
update_profit()
update_money()
update_land()
update_shipments()
update_text()
$(document).ready( -> setInterval(timer_step, 1000) )