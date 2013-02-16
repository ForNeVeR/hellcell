requestAnimFrame = window.requestAnimationFrame ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame ||
	window.oRequestAnimationFrame ||
	window.msRequestAnimationFrame ||
	(callback, element) -> window.setTimeout callback, 1000 / 60

canvas = document.getElementById 'canvas'

initialize = ->
	[]

field = initialize()
lastTime = 0
live = (time) ->
	delta = time - lastTime
	if delta != 0
		field = update field
		render canvas, delta, field
		lastTime = time

	requestAnimFrame live, canvas

update = (field) ->
	field

render = (canvas, time, field) ->
	alert time

live(0)
