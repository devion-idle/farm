# Farmer
$('#hire_farmer').button().click( -> 
  potato.num_farmers++
  potato.update_crop_timing()
  update_profit()
  update_text())
$('#fire_farmer').button().click( -> 
  potato.num_farmers-- if potato.num_farmers > 1
  potato.update_crop_timing()
  update_profit()
  update_text())
  
# Driver
$('#hire_driver').button().click( -> 
  num_drivers++
  num_drivers_max++
  update_profit()
  update_text())
$('#fire_driver').button().click( -> 
  if num_drivers > 1
    num_drivers--
    num_drivers_max--
  update_profit()
  update_text())
  
# Tiller
$('#hire_tiller').button().click( -> 
  num_tillers++
  update_land_timing()
  update_profit()
  update_text())
$('#fire_tiller').button().click( -> 
  num_tillers-- if num_tillers > 1
  update_land_timing()
  update_profit()
  update_text())