# Motivation global variables
motivate_bonus = 0
motivate_bonus_max = 3
motivate_level = 1
motivate_timer = 0
motivate_timer_max = 30

# Motivate Workers Button callbacks
$('#motivate_workers').button().click( ->
  motivate_bonus++ if (motivate_bonus < motivate_bonus_max)
  motivate_timer = motivate_timer_max
  motivate_level = 1 + motivate_bonus
  update_motivate_text()
  potato.update_crop_timing()
  potato.update_crop_text()
  update_profit()
  update_financial_text()
)

update_motivate = ->
  motivate_timer-- if motivate_timer > 0
  if motivate_timer <= 0 && motivate_bonus > 0
    motivate_bonus--
    motivate_timer = motivate_timer_max
    motivate_level = 1 + motivate_bonus
    potato.update_crop_timing()
    potato.update_crop_text()
    update_profit()
    update_financial_text()


# Update motivate text
update_motivate_text = ->
  $("#motivate_bonus").text("#{motivate_bonus}/#{motivate_bonus_max}")
  $("#motivate_timer").text("#{motivate_timer} sec")