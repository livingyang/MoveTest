loadImages = (sources, callback) ->
	images = {}
	loadedImages = 0
	numImages = 0
	for src of sources
		numImages++
	
	for src of sources
		images[src] = new Image()
		images[src].onload = ->
			callback images  if ++loadedImages >= numImages

		images[src].src = sources[src]

Template.hello.greeting = ->
	"Welcome to app."

Template.hello.events "click input": =>
	# @loadImages()
	# for i in [1..8]
	# 	move('img' + i)
	# 	.rotate(Math.random() * 360)
	# 	.end()	

Meteor.startup ->
	# @loadImages()
	
	console.log "Start!!"
	console.log new Date()
		
	images =
		img1: "1.png"
		img2: "2.png"
		img3: "3.png"
		img4: "4.png"

	loadImages images, (images) ->
		console.log new Date()
		console.log "image loaded"

		stage = new Kinetic.Stage
			container: 'container'
			width: 578
			height: 530

		layer = new Kinetic.Layer()

		# rect = new Kinetic.Rect
		# 	x: 239,
		# 	y: 75,
		# 	width: 100,
		# 	height: 50,
		# 	fill: 'green',
		# 	stroke: 'black',
		# 	strokeWidth: 4
		imgArray = for i in [1..1]
			# console.log i
			img = new Kinetic.Image
				x: 0
				y: i * 50
				width: 100
				height: 100
				image: images["img" + i]
			layer.add img
			img
	              
		# layer.add rect
		stage.add layer

		amplitude = 150
		period = 2000
		centerX = stage.getWidth() / 2

		anim = new Kinetic.Animation (frame) ->
			img.setX(amplitude * Math.sin(frame.time * 2 * Math.PI / period) + centerX) for img in imgArray
		, layer

		anim.start()

# code to run on server at startup
