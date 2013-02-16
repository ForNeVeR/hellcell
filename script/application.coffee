requestAnimFrame = window.requestAnimationFrame ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame ||
	window.oRequestAnimationFrame ||
	window.msRequestAnimationFrame ||
	(callback, element) -> window.setTimeout callback, 1000 / 60

window.onload = ->
	canvas = document.getElementById 'canvas'
	context = canvas.getContext '2d'

	initialize = ->
		array = []
		for row_index in [1..800]
			row = []
			for cell_index in [1..600]
				row.push (Math.floor (Math.random() * 4))
			array.push row
		array

	field = initialize()
	last_time = 0
	live = (time) ->
		delta = time - last_time
		if delta != 0
			if update delta, field
				last_time = time
				render field

		requestAnimFrame live, canvas

	update = (delta, field) ->
		if delta <= 10
			false
		else
			for x in [1..598]
				for y in [1..798]
					north = field[y - 1][x]
					west = field[y][x - 1]
					center = field[x][y]
					east = field[y][x + 1]
					south = field[x + 1][x]

					next = (center + 1) % 3
					if north == next || west == next || east == next || south == next
						field[x][y] = next
			true

	render = (field) ->
		image = context.createImageData 800, 600
		for x in [0..599]
				for y in [0..799]
					index = (y * 800 + x) * 4
					cell = field[y][x]
					if cell == 0
						image.data[index] = 255
					else if cell == 1
						image.data[index + 1] = 255
					else if cell == 2
						image.data[index + 2] = 255
					image.data[index + 3] = 255
		context.putImageData image, 0, 0

	live 0
