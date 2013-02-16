requestAnimFrame = window.requestAnimationFrame ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame ||
	window.oRequestAnimationFrame ||
	window.msRequestAnimationFrame ||
	(callback, element) -> window.setTimeout callback, 1000 / 60

hsv_to_rgb = (h, s, v) ->
	h_i = Math.floor(h / (Math.PI / 3))
	v_min = (1 - s) * v
	a = (v - v_min) * (h - (Math.PI / 3) * h_i)
	v_inc = v_min + a
	v_dec = v - a
	switch h_i
		when 0
			[v, v_inc, v_min]
		when 1
			[v_dec, v, v_min]
		when 2
			[v_min, v, v_inc]
		when 3
			[v_min, v_dec, v]
		when 4
			[v_inc, v_min, v]
		when 5
			[v, v_min, v_dec]

width = 800
height = 600
state_count = 16

window.onload = ->
	canvas = document.getElementById 'canvas'
	context = canvas.getContext '2d'

	initialize = ->
		array = []
		for row_index in [1..height]
			row = []
			for cell_index in [1..width]
				row.push (Math.floor (Math.random() * state_count))
			array.push row
		array

	field = initialize()
	last_time = 0
	live = (time) ->
		delta = time - last_time
		if delta != 0
			field = update delta, field
			last_time = time
			render field

		requestAnimFrame live, canvas

	update = (delta, field) ->
		new_field = []
		for y in [0..height - 1]
			new_row = []
			new_field.push new_row

			for x in [0..width - 1]
				center = field[y][x]

				#north = if y > 0 then field[y - 1][x] else null
				#west = if x > 0 then field[y][x - 1] else null
				#east = if x < width - 1 then field[y][x + 1] else null
				#south = if y < height - 1 then field[y + 1][x] else null

				north = field[(y + height - 1) % height][ x                     ]
				south = field[(y          + 1) % height][ x                     ]
				west  = field[ y                       ][(x + width - 1) % width]
				east  = field[ y                       ][(x         + 1) % width]

				next = (center + 1) % state_count
				if north == next || west == next || east == next || south == next
					new_row[x] = next
				else
					new_row[x] = center
		new_field

	render = (field) ->
		image = context.createImageData width, height
		for x in [0..width - 1]
				for y in [0..height - 1]
					index = (y * width + x) * 4
					cell = field[y][x]
					h = cell / state_count * Math.PI * 2
					[r, g, b] = hsv_to_rgb(h, 1, 1)

					image.data[index] = r * 255
					image.data[index + 1] = g * 255
					image.data[index + 2] = b * 255
					image.data[index + 3] = 255

		context.putImageData image, 0, 0

	live 0
