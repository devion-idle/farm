# Industry global variables
num_drivers = 1
num_drivers_max = 1
num_drivers_limit = 2

# Shipment class to launch new crop shipments
class Shipment
  constructor: (@crop, @num_shipping, @time_shipping) ->
    Shipment.current.push(this)

  @current: []
  
  remove: (index) ->
    num_drivers++
    Shipment.current.splice(index,1)
    @crop.num_shipping -= @num_shipping
    money += @crop.val_crop*@num_shipping      
      
# Update shipments
update_shipments = ->
  for i in Shipment.current
    if typeof i != 'undefined'
      if i.time_shipping > 0 
        i.time_shipping--
      else
        i.remove(Shipment.current.indexOf(i)) 
    
# Update industry text
update_industry_text = ->
  $("#num_drivers").text("#{num_drivers}/#{num_drivers_max}")