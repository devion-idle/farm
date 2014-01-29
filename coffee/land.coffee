# Land global variables
land_available = 0
land_owned = 10
land_max = 30
num_tillers = 0
time_tilling = 0
time_tilling_max = 60
time_tilling_increase = 1.2

# Update land timing
update_land_timing = ->
  if num_tillers > 0
    percentage_tilled = time_tilling/time_tilling_max
    time_tilling_max = Math.round(60*Math.pow(time_tilling_increase, land_owned-10)/num_tillers)
    time_tilling = Math.round(time_tilling_max*(percentage_tilled))
  
# Update land
update_land = ->
  time_tilling++ if num_tillers > 0
  if time_tilling >= time_tilling_max
    if land_owned < land_max
      time_tilling -= time_tilling_max
      land_owned++
      #land_available++
      potato.num_acres++
      num_farmers_limit = Math.floor(land_owned/2)
      num_drivers_limit = 2*Math.log(land_owned)*Math.LOG10E;
      update_store()
      update_land_timing()
      update_profit()
      update_text()
    else
      time_tilling = time_tilling_max
      
    

# Update land text
update_land_text = ->
  $('#land_available').text("#{land_available} acres")
  $('#land_owned').text("#{land_owned}/#{land_max} acres")
  $('#num_tillers').text(num_tillers)
  $('#time_tilling').text("#{time_tilling_max - time_tilling} (#{time_tilling_max}) sec")

