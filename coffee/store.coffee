# -- Workers --

# Farmer Button callbacks
$('#hire_farmer').button().click( -> 
  potato.num_farmers++
  potato.update_crop_timing()
  update_profit()
  update_store()
  update_text()
)
$('#fire_farmer').button().click( -> 
  potato.num_farmers-- 
  potato.update_crop_timing()
  update_profit()
  update_store()
  update_text()
)
  
# Driver Button callbacks
$('#hire_driver').button().click( -> 
  num_drivers++
  num_drivers_max++  
  update_profit()
  update_store()
  update_text()
)
$('#fire_driver').button().click( -> 
  num_drivers--
  num_drivers_max--  
  update_profit()
  update_store()
  update_text()
)
  
# Tiller Button callbacks
$('#hire_tiller').button().click( -> 
  num_tillers++
  update_land_timing()
  update_profit()
  update_store()
  update_text()
)
$('#fire_tiller').button().click( -> 
  num_tillers--
  update_land_timing()
  update_profit()
  update_store()
  update_text()
)

# -- Tools --
trowel = 1
fertilizer = 0
fuzzy_dice = 1
truck_decals = 0
hoe = 1
cultivator = 0

$('#trowel').button().click( ->
  trowel++
)
$('#fertilizer').button().click( ->
  fertilizer++
)

$('#fuzzy_dice').button().click( ->
  fuzzy_dice++
)
$('#truck_decals').button().click( ->
  truck_decals++
)

$('#hoe').button().click( ->
  hoe++
)
$('#cultivator').button().click( ->
  cultivator++
)

# Update store
update_store = ->
  # Farmer
  if potato.num_farmers >= num_farmers_limit || net <= 0
    $('#hire_farmer').button("disable")
  else
    $('#hire_farmer').button("enable")
  if potato.num_farmers < 2
    $('#fire_farmer').button("disable") 
  else
    $('#fire_farmer').button("enable")
    
  # Driver
  if num_drivers_max >= num_drivers_limit || net <= 0
    $('#hire_driver').button("disable") 
  else
    $('#hire_driver').button("enable") 
  if num_drivers < 1 || num_drivers_max < 2
    $('#fire_driver').button("disable")
  else
    $('#fire_driver').button("enable")
    
  # Tiller
  if num_tillers < 1
    $('#fire_tiller').button("disable") 
  else
    $('#fire_tiller').button("enable")
  if land_owned >= land_max || net < wage
    $('#hire_tiller').button("disable") 
  else
    $('#hire_tiller').button("enable")
    

# Initialization
$('#hire_farmer').button("enable")
$('#hire_driver').button("enable")
$('#hire_tiller').button("disable")
$('#fire_farmer').button("disable")
$('#fire_driver').button("disable")
$('#fire_tiller').button("disable")