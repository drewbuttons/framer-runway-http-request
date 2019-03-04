
#This is the caption that will be sent to Runway's AttnGAN model -- feel free to change it
testString = "a fairy sleeping in the forest"

#This function handles the POST request to Runway -- you may need to change the local port to 8002,8003,etc. depending on what Runway tells you
sendIt = (sendString) ->
	inputs = 
		'caption': sendString
	fetch 'http://localhost:8001/query',
		method: 'POST'
		headers:
			Accept: 'application/json'
			'Content-Type': 'application/json'
		body: JSON.stringify(inputs)
	.then (response) ->
# 		console.log response.json()
		ganRes = response.json().then (data) ->
			console.log data.result
			ganImg = data.result
			placeHolder.image = ganImg


bttn = new Layer
	height: 60
	width: 240
	borderRadius: 12
	backgroundColor: "blue"
	
bttnLabel = new TextLayer
	text: "Send to AttnGAN"
	fontSize: 21
	color: "white"
	parent: bttn
	x: Align.center
	y: Align.center

topLabel = new TextLayer
	text: "CAPTION"
	fontSize: 16
	fontWeight: "bold"
	x: Align.center
	y: 80
	
captionTxt = new TextLayer
	text: testString
	fontSize: 21
	color: "black"
	x: Align.center
	y: topLabel.maxY + 10

bttn.center()
bttn.y = captionTxt.maxY + 40
	
placeHolder = new Layer
	height: 160
	width: 160
	backgroundColor: null
	borderColor: "grey"
	borderWidth: 1
	x: Align.center
	y: bttn.maxY + 50

#Send the caption to Runway when you click the button	
bttn.onClick ->
	sendIt(testString)