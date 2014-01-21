number = 0
timer = ->
  number += 1
  $('#test').text(number);
$(document).ready( -> 
  setInterval(timer, 1000)
)