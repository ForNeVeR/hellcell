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
live = (time) ->
	field = update field
	render canvas, time, field
	requestAnimFrame live, canvas

update = (field) ->
	field

render = (canvas, time, field) ->
	alert time

live(0)
