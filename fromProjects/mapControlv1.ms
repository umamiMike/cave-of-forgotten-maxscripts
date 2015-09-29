---add random function for color from and to

--add a button to make all selected objects materials unique for i in selection do (i.material = copy i.material)


--all objects in selection ... somehow group all materials with the same "Opacity" filename


if mapControlRoll != undefined do (destroydialog mapcontrolroll)


fn findMyMaps theName = (
			myShit = #()
			for i in selection do (myShit += getClassInstances RGB_Multiply target:i)
			mapsToChange = for i in myShit where  i.name ==  theName collect i--filters for name of map
	
		return mapsToChange
)



 
 fn subFromArray array1 array2 = (
	-- this will subtract all items from array2 which exist in array1
	tempArray = deepcopy array2
		for i in array1 do(
			v =  findItem tempArray i
			while v != 0 do (
			deleteItem	tempArray v
			v =  findItem tempArray i
				
			)
			
		)
		return tempArray
	
)

fn makeInstanceArray  = (
	
	 mySel = selection as Array
	groupsOfObs = #()
	while mySel.count != 0 do (
		
		 myFilename = mySel[1].material.texmap_opacity.filename
 
		filteredObs = for i in selection where i.material.texmap_opacity.filename  == myFilename  collect i
		append groupsOfObs filteredObs
		mySel = subFromArray filteredObs mySel
		
	)
	
	return groupsOfObs
	)
	
	
	fn makeInstancesOfMats = (
	myInstances = makeInstanceArray()
	
	for i in myInstances do (
		
		myMat = copy i[1].material
		for o in i do (o.material = myMat)
		
		
	)
	
	free myInstances
	
)



rollout mapControlRoll "mapControlV1" width:266 height:247
(
	colorPicker cp1 "" pos:[9,22] width:16 height:16 color:(color 128 128 128)
	GroupBox Control1 "Control 1" pos:[5,7] width:253 height:72
	
	edittext edt2 "" pos:[32,22] width:120 height:16 text:"fillColor"
 
 
 
	label lbl1 "Name of Map" pos:[157,22] width:92 height:16
	button rnBtn "<->" pos:[108,46] width:32 height:16 toolTip:"Randomize between colors"
		--change the colors of all the rgb mults with the correct name to the current color

	colorPicker fromCP "" pos:[7,47] width:92 height:15 color:(color 0 0 0)
	colorPicker toCP "" pos:[144,47] width:92 height:15 color:(color 255 255 255)
		

	colorPicker cp19 "" pos:[8,98] width:16 height:16 color:(color 128 128 128)
	GroupBox grp7 "Control 2" pos:[4,84] width:253 height:72
	edittext edt7 "" pos:[31,99] width:120 height:16 text:"StrokeColor"
 
 
	label lbl7 "Name of Map" pos:[157,99] width:86 height:16
	button btn10 "<->" pos:[107,123] width:32 height:16 toolTip:"Randomize between colors"
		--change the colors of all the rgb mults with the correct name to the current color

	colorPicker fromCP2 "" pos:[6,124] width:92 height:15 color:(color 0 0 0 )
	colorPicker toCP2 "" pos:[143,124] width:92 height:15 color:(color 255 255 255)
	button makeMatsUniqueBtn "Make ALL Selected Mats Unique" pos:[11,177] width:245 height:17 toolTip:"If there are a lot of objects selected this could be dangerous.  Use sparingly."
	progressBar pb1 "ProgressBar" pos:[8,228] width:248 height:13
		

	button btn4 "Make Instances of selected Mats" pos:[12,203] width:245 height:17
	on cp1 changed col do
	(undo on(
			mapsToChange = findMyMaps edt2.text
			for i in mapsToChange do (try (i.color1 = mapControlRoll.cp1.color ) catch())
			)
		)
	on rnBtn pressed do
	(undo on(
		mapsToChange = findMyMaps edt2.text
		for i in mapsToChange do (try (i.color1 = random  fromCP.color toCP.color) catch())
		)--end undo
		)--run the procedure
	on cp19 changed col do
	(undo on(
			mapsToChange = findMyMaps edt7.text
			for i in mapsToChange do (try (i.color1 = cp19.color ) catch())
			)--endundo
		)
	on btn10 pressed do
	(undo on(
		mapsToChange = findMyMaps edt7.text
		for i in mapsToChange do (try (i.color1 = random  fromCP2.color toCP2.color) catch())
		)--end undo
		)--run the procedure
	on makeMatsUniqueBtn pressed do
	(
			undo on(
			try(for i= 1 to  selection.count do (
						selection[i].material = copy selection[i].material
					--	theProgress = 100 * 1/selection.count
							pb1.value = 100*i/selection.count
									)
				)
				catch()
				pb1.value = 0
			)--end undo
		)
	on btn4 pressed do
	(
			undo on(
				try(makeInstancesOfMats()) 
				catch(messagebox "something went wrong")
	
				
			)--end undo
		)
)


createDialog mapControlRoll