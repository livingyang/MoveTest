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
	
testCreateJs = ->

Template.move.events "click .play": =>
	move('#example-10 .box1').skew(50).x(400).end();
	move('#example-10 .box2').ease('in').skew(50).x(400).end();
	move('#example-10 .box3').ease('out').skew(50).x(400).end();
	move('#example-10 .box4').ease('in-out').skew(50).x(400).end();
	move('#example-10 .box5').ease('snap').skew(50).x(400).end();
	move('#example-10 .box6').ease('cubic-bezier(0,1,1,0)').skew(50).x(400).end();

	setTimeout( ->
		move('#example-10 .box1').x(0).end();
		move('#example-10 .box2').x(0).end();
		move('#example-10 .box3').x(0).end();
		move('#example-10 .box4').x(0).end();
		move('#example-10 .box5').x(0).end();
		move('#example-10 .box6').x(0).end();
	, 1200)

Template.transit.events "click #reset": ->
	$("#cards-container").css
		x: 0
		y: 0

	$("#cards").css
		rotate3d : '0, 0, 0, 0deg'
		scale: 1
	return
	$("#cards").css
		perspective: 0
		x: 0
		y: 0
		rotate3d : '0, 0, 0, 0deg'
		scale: 1

randomEnemy = ->

	randomPos = ->
		x: Math.random() * 20
		y: Math.random() * 30
		duration: 50

	$("#enemy")
	.transition(randomPos())
	.transition(randomPos())
	.transition(randomPos())
	.transition(randomPos())
	.transition(randomPos())
	.transition x: 0, y: 0, duration: 50

Template.transit.events "click #click1": ->
	randomEnemy()
	return
	$("#cards").css
		scale: [0.1, 0.1]
		# rotateX: '45deg'
	$("#cards").css
		perspective: 100
		x: 0
		y: 100

Template.transit.events "click #click2": ->

	$("#cards-container").transition y: -300, ->
		$("#cards-container").transition
			y: "-=100"
			x: "+=300"

		$("#cards").css
		 perspective: 100

		$("#cards")
		.transition
			rotate3d : '0.7, 0.5, 0.7, 45deg'
		.transition scale: 0.1, 300, "in", -> randomEnemy()
	return;
	# $("#cards").css
	# 	perspective: 100
	# 	x: 0
	# 	y: 100
	# $("#cards").css
	# 	scale: [0.1, 0.1]
	# 	rotateX: '45deg'
	# return
	$("#cards").css(perspective: 100)

	# $("#cards").css x: 0, y: 40, scale: [0.1, 0.1], rotateX: '45deg'
	# return
	$('#cards')
	# .css
		# transformOrigin: '100px -100px'
	.transition
		y: -500
	.transition
		# perspective: '100px',
		# rotateX: '45deg'
		# rotateY: '0deg'
		rotate3d : '0.7, 0.5, 0.7, 45deg'
	.transition
		# perspective: 1000
		x: 1000
		# rotateX: '45deg'
		y: -1000
		scale: [0.5, 0.5, 0.5]
	# .transition
	# 	# perspective: '100px',
	# 	rotateX: '0deg'
	# 	x: 0
	# 	y: 0
	# 	scale: 1

Meteor.startup ->
	# @loadImages()
	
	console.log "Start!!"
	console.log new Date()
		
	# testKinect()
	# testColliejs()
	# testCreateJs();

# code to run on server at startup
