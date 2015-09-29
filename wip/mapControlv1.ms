---add random function for color from and to




if mapControlRoll != undefined do (destroydialog mapcontrolroll)


fn findMyMaps theName = (
			myShit = #()
			for i in selection do (myShit += getClassInstances RGB_Multiply target:i)
			mapsToChange = for i in myShit where  i.name ==  theName collect i--filters for name of map
	
		return mapsToChange
)


rollout mapControlRoll "mapControlV1" width:266 height:165
(
	colorPicker cp1 "" pos:[9,22] width:16 height:16
	GroupBox Control1 "Control 1" pos:[5,7] width:253 height:72
	
	edittext edt2 "" pos:[32,22] width:120 height:16 text:"fillColor"
 
 
 
	label lbl1 "Name of Map" pos:[157,22] width:92 height:16
	button rnBtn "<->" pos:[108,46] width:32 height:16 toolTip:"Randomize between colors"
		--change the colors of all the rgb mults with the correct name to the current color

	colorPicker fromCP "" pos:[7,47] width:92 height:15 color:(color 0 0 155)
	colorPicker toCP "" pos:[144,47] width:92 height:15 color:(color 0 0 155)
		

	colorPicker cp19 "" pos:[8,98] width:16 height:16 color:(color 0 0 155)
	GroupBox grp7 "Control 2" pos:[4,84] width:253 height:72
	edittext edt7 "" pos:[31,99] width:120 height:16 text:"StrokeColor"
 
 
	label lbl7 "Name of Map" pos:[157,99] width:86 height:16
	button btn10 "<->" pos:[107,123] width:32 height:16 toolTip:"Randomize between colors"
		--change the colors of all the rgb mults with the correct name to the current color

	colorPicker fromCP2 "" pos:[6,124] width:92 height:15 color:(color 0 0 155)
	colorPicker toCP2 "" pos:[143,124] width:92 height:15 color:(color 0 0 155)
		

	on cp1 changed col do
	(
			findMyMaps edt2.text
			for i in mapsToChange do (try (i.color1 = mapControlRoll.cp1.color ) catch())
		)
	on rnBtn pressed do
	(
		findMyMaps edt2.text
		for i in mapsToChange do (try (i.color1 = random  fromCP.color toCP.color) catch())
		
		)--run the procedure
	on cp19 changed col do
	(
			findMyMaps edt7.text
			for i in mapsToChange do (try (i.color1 = cp19.color ) catch())
		)
	on btn10 pressed do
	(
		findMyMaps edt7.text
		for i in mapsToChange do (try (i.color1 = random  fromCP2.color toCP2.color) catch())
		
		)--run the procedure
)


createDialog mapControlRoll