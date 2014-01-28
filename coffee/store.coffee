# Farmer Button callbacks
$('#hire_farmer').button().click( -> 
  potato.num_farmers++
  potato.update_crop_timing()
  update_profit()
  update_store()
  update_text())
$('#fire_farmer').button().click( -> 
  potato.num_farmers-- 
  potato.update_crop_timing()
  update_profit()
  update_store()
  update_text())
  
# Driver
$('#hire_driver').button().click( -> 
  num_drivers++
  num_drivers_max++  
  update_profit()
  update_store()
  update_text())
$('#fire_driver').button().click( -> 
  num_drivers--
  num_drivers_max--  
  update_profit()
  update_store()
  update_text())
  
# Tiller
$('#hire_tiller').button().click( -> 
  num_tillers++
  update_land_timing()
  update_profit()
  update_store()
  update_text())
$('#fire_tiller').button().click( -> 
  num_tillers--
  update_land_timing()
  update_profit()
  update_store()
  update_text())

  
# Update store
update_store = ->
  # Farmer
  if potato.num_farmers >= num_farmers_limit
    $('#hire_farmer').button("disable")
  else
    $('#hire_farmer').button("enable")
  if potato.num_farmers < 2
    $('#fire_farmer').button("disable") 
  else
    $('#fire_farmer').button("enable")
    
  # Driver
  if num_drivers_max >= num_drivers_limit
    $('#hire_driver').button("disable") 
  else
    $('#hire_driver').button("enable") 
  if num_drivers < 2
    $('#fire_driver').button("disable")
  else
    $('#fire_driver').button("enable")
    
  # Tiller
  if num_tillers < 1
    $('#fire_tiller').button("disable") 
  else
    $('#fire_tiller').button("enable")
    
    
# Initialization
$('#hire_farmer').button("enable")
$('#hire_driver').button("enable")
$('#hire_tiller').button("enable")
$('#fire_farmer').button("disable")
$('#fire_driver').button("disable")
$('#fire_tiller').button("disable")