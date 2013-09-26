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

testKinect = ->
	images =
		img1: "1.png"
		img2: "2.png"
		img3: "3.png"
		img4: "4.png"
		lion: "lion.png"

	loadImages images, (images) ->
		console.log new Date()
		console.log "image loaded"

		stage = new Kinetic.Stage
			container: 'container'
			width: 300
			height: 300

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
				# image: images["img" + i]
				image: images["lion"]
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

testColliejs = ->

		layer = new collie.Layer
			width : 300,
			height : 300
		
		collie.ImageManager.add('lion', '1.png')
		oDisplayObject = new collie.DisplayObject
			x : 0,
			y : 0,
			# width: "auto"
			# height: "auto"
			# width : 103,
			# height : 87,
			# scaleX: 0.5
			# scaleY: 0.5
			backgroundImage : 'lion'
			velocityX : 400,
			# backgroundRepeat : "repeat-x",
			# rangeX : [0, 320]
			# positionRepeat : true
		.addTo(layer)

		# oDisplayObject.resizeFixedRatio 100, 100
		# oDisplayObject.set "scaleX", 1#100 / oDisplayObject.get "width"
		# oDisplayObject.set "scaleY", 100 / oDisplayObject.get "height"

		collie.Timer.repeat (e) ->
			vX = oDisplayObject.get "velocityX"
			oDisplayObject.set "velocityX", -vX

			oDisplayObject.set "x", if vX < 0 then -300 else 400
			
		, 2000
		
		# // 바로 하기
		# collie.ImageManager.add('collie2', '../img/large/collie_shape.png', function (elImage) {
		# 	var oDisplayObject = new collie.DisplayObject({
		# 		x : 50,
		# 		y : 50,
		# 		width : 103,
		# 		height : 87,
		# 		zIndex : 2,
		# 		backgroundImage : elImage
		# 	});
		# 	layer.addChild(oDisplayObject);	
		# });
		
		# // 한꺼번에 하기
		# collie.ImageManager.add({
		# 	"collie3" : '../img/large/collie_shape.png',
		# 	"collie4" : '../img/large/collie_shape.png'
		# }, function () {
		# 	new collie.DisplayObject({
		# 		x : 70,
		# 		y : 70,
		# 		width : 103,
		# 		height : 87,
		# 		zIndex : 3,
		# 		backgroundImage : "collie3"
		# 	}).addTo(layer);
		# 	new collie.DisplayObject({
		# 		x : 100,
		# 		y : 100,
		# 		width : 103,
		# 		height : 87,
		# 		zIndex : 3,
		# 		backgroundImage : "collie4"
		# 	}).addTo(layer);
		# });

		collie.Renderer.addLayer(layer)
		collie.Renderer.load(document.getElementById("container"))
		collie.Renderer.start()
	

Meteor.startup ->
	# @loadImages()
	
	console.log "Start!!"
	console.log new Date()
		
	# testKinect()
	testColliejs()

# code to run on server at startup
