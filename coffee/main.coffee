# Update text
update_text = ->
  update_financial_text()
  potato.update_crop_text()
  
# Timer function, called every 1 second
timer_step = ->
  potato.update_crop()  
  update_money()
  update_text()
  
# Initialization
update_text()
$(document).ready( -> setInterval(timer_step, 1000) )



