# Crop class
class Crop
  constructor: (@name, @val_seed, @val_crop) ->
    @num_farmers = 0
    @num_acres = 0
    @num_harvested = 0
    @num_shipping = 0
    @time_harvest = 0
    @time_harvest_max = 0
    @time_shipping_max = 0
    @num_drivers_needed = 0

  # Update timing
  update_crop_timing: ->
    this.time_harvest_max = this.num_acres/(this.num_farmers*0.2)
    this.time_harvest = (this.num_acres - this.num_harvested)/(
      this.num_farmers*0.2)
    this.time_shipping_max = 20*Math.log(this.num_acres)*Math.LOG10E
    this.num_drivers_needed = this.time_shipping_max/this.time_harvest_max
      
  # Update crop text
  update_crop_text: ->
    $(".#{this.name} #num_farmers").text(this.num_farmers)
    $(".#{this.name} #num_acres").text(this.num_acres)
    $(".#{this.name} #num_harvested").text(Math.floor(this.num_harvested))
    $(".#{this.name} #num_shipping").text(Math.floor(this.num_shipping))
    $(".#{this.name} #time_harvest").text(
      "#{Math.ceil(this.time_harvest)} (#{Math.ceil(this.time_harvest_max)}) sec")
    $(".#{this.name} #time_shipping").text(
      "#{Math.ceil(this.time_shipping_max)} sec")
    $(".#{this.name} #num_drivers_needed").text(Math.ceil(this.num_drivers_needed))
      
  # Update crop, called every 1 second
  update_crop: ->
    # Update crop harvested
    this.num_harvested = Math.min(this.num_acres, 
      this.num_harvested + this.num_farmers*0.2) # 5 seconds/this/farmer    
    this.time_harvest-- if this.time_harvest > 0
    
    # Start crop shipping
    if this.num_harvested >= this.num_acres and num_drivers > 0
      this.num_shipping += this.num_harvested
      money -= this.val_seed*this.num_acres
      num_drivers--
      update_store()
      new Shipment(this, this.num_harvested, this.time_shipping_max)
      this.num_harvested = 0
      this.time_harvest = this.time_harvest_max

# Motivation global variables
motivate_bonus = 0
motivate_bonus_max = 3
motivate_timer = 0
motivate_timer_max = 30

# Motivate Workers Button callbacks
$('#motivate_workers').button().click( ->
  motivate_bonus++ if (motivate_bonus < motivate_bonus_max)
  motivate_timer = motivate_timer_max;
  update_motivate_text()
)

update_motivate = ->
  motivate_timer-- if motivate_timer > 0
  if motivate_timer <= 0 && motivate_bonus > 0
    motivate_bonus--
    motivate_timer = motivate_timer_max



# Update motivate text
update_motivate_text = ->
  $("#motivate_bonus").text("#{motivate_bonus}/#{motivate_bonus_max}")
  $("#motivate_timer").text("#{motivate_timer} sec");


# Initialization
num_farmers_limit = 5
potato = new Crop('potato', 0.50, 2)
potato.num_farmers = 1
potato.num_acres = 10
potato.num_drivers_max = 1
potato.num_drivers = 1
potato.update_crop_timing()



