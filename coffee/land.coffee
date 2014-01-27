land_available = 0
land_owned = 10
land_max = 30
num_tillers = 0
time_tilling = 0
time_tilling_max = 60
time_tilling_increase = 1.2

# Update land timing
update_land_timing = ->
  percentage_tilled = time_tilling/time_tilling_max
  time_tilling_max = Math.round(60*Math.pow(land_owned-9, time_tilling_increase)/num_tillers)
  time_tilling = Math.round(time_tilling_max*(percentage_tilled))
  
# Update land
update_land = ->
  time_tilling++ if num_tillers > 0
  if time_tilling > time_tilling_max
    time_tilling -= time_tilling_max
    land_owned++
    land_available++
    update_land_timing()

# Update land text
update_land_text = ->
  $('#land_available').text("#{land_available} acres")
  $('#land_owned').text("#{land_owned}/#{land_max} acres")
  $('#num_tillers').text(num_tillers)
  $('#time_tilling').text("#{time_tilling_max - time_tilling} (#{time_tilling_max}) sec")

