if vrMeshCmdRoll != undefined do (destroydialog vrMeshCmdRoll)

--theBricks = for o in objects where hasproperty o "filename" and o.filename == "J:\PROJECTS\Strada Unlimited\Ricks Bricks\assets\max\proxy\heroBrickV1.vrmesh" collect o

--press a button, make an array of the objects
-- select a set of objects to scatter to
-- randomly go through the array, pick an object, and transfer it's filename and material to the scattertoObject
-- parse a directory picked byt a button for any tif


theFiles
theFileNames
thisfile
theLbxArray

theObsToScatter = #()

fn selectMeshByFile = (
	
	c = vrMeshCmdRoll.lbx1.selection as array
			theIndex = c[1]
			itm = theFiles[theIndex]
	
	select( for o in objects where hasproperty o "filename" and o.filename == itm collect o)
	
	
)


fn refSubDivs = (

for i in scenematerials where classof i == VRayMtl do ( i.reflection_subdivs = 24
	print i
	print i.reflection_subdivs
	)

)



fn selByWire = (

			--this is the action item "select by color" most people don't even know you can do that.  useful for selecting a group of objects with the same wirecolor
				try(
				myWire = selection[1].wirecolor
				selWires = for i in objects where i.wirecolor == myWire collect i
					select selWires
					)
				catch(messagebox("No item originally Selected"))	
	
	
)


fn getvrmeshesInDir stringOfFileType = (
			--reinitializing various arrays
			filesarray = #()
	
		lastPCFile = getOpenFileName types:"vrmesh(*.vrmesh)|" caption:"Select any vrmesh in the directory"
		if lastPCFile == undefined do (return false)
		Mydirectory = getFileNamePath lastPCFile
		theFullDirectory = myDirectory + stringOfFileType--"*.vrmesh"
		thePC2s = getFiles theFullDirectory
		PCsInDir = thePC2s
		PCFileNamesInDir =  for i in thePC2s collect (fileNameFromPath i)
	theFileNames =  for i in thePC2s collect (getFileNameFile i)
	--if pcFileNamesInDir.count < 10 do (vrMeshCmdRoll.lbx1.height = pcFileNamesInDir.count)
	--ui changing
		--vrMeshCmdRoll.lbx1.height = theFileNames.count * 14
		vrMeshCmdRoll.lbx1.items = theFileNames
		vrMeshCmdRoll.btn1.caption = myDirectory
		--return filenameArray
	return pcsindir

)	

fn getImagesInDir stringOfFileType = (
			--reinitializing various arrays
			filesarray = #()
	
		lastPCFile = getOpenFileName types:"vrmesh(*.vrmesh)|" caption:"Select any vrmesh in the directory"
		if lastPCFile == undefined do (return false)
		Mydirectory = getFileNamePath lastPCFile
		theFullDirectory = myDirectory + stringOfFileType--"*.vrmesh"
		thePC2s = getFiles theFullDirectory
		PCsInDir = thePC2s
		PCFileNamesInDir =  for i in thePC2s collect (fileNameFromPath i)
	theFileNames =  for i in thePC2s collect (getFileNameFile i)
	--if pcFileNamesInDir.count < 10 do (vrMeshCmdRoll.lbx1.height = pcFileNamesInDir.count)
	--ui changing
		--vrMeshCmdRoll.lbx1.height = theFileNames.count * 14
		vrMeshCmdRoll.lbx1.items = theFileNames
		vrMeshCmdRoll.btn1.caption = myDirectory
		--return filenameArray
	return pcsindir

)	




rollout vrMeshCmdRoll "vr mesh commander" width:376 height:427
(
	multiListBox lbx1 "vrmeshes in directory" pos:[19,66] width:150 height:10
	button btn1 "collect vrMeshes in Dir" pos:[16,30] width:339 height:26
	button btn4 "scatter them" pos:[232,73] width:124 height:26
	button btn3 "Select same Wire Color" pos:[232,137] width:124 height:20
	spinner spn1 "scale selected  proxies" pos:[260,177] width:96 height:16 range:[-100,100,0]
 
 

	
	button btn11 "sel all insances of vrmesh" pos:[232,109] width:124 height:20
	groupBox grp1 "GroupBox" pos:[8,3] width:360 height:246
	on btn1 pressed do
		(theFiles = getvrmeshesInDir "*.vrmesh")
	on btn4 pressed do
	(
			c = vrMeshCmdRoll.lbx1.selection as array
			theIndex = c[1]
			itm = vrMeshCmdRoll.lbx1.items
				for i in selection do
				(
					try(i.filename = theFiles[c[1]]) catch()
					--try(i.material = scenematerials[theFilenames[c[1]]]) catch(messagebox "no material by that name")
				)
				
			)
	on btn3 pressed do
		(selbyWire())
	on spn1 changed val do
	(
		
		for i in selection where hasproperty i "proxy_scale" do (i.proxy_scale = val)
	)
	on btn11 pressed do
		(selectMeshByFile())
)
	
	
	
createDialog vrMeshCmdRoll