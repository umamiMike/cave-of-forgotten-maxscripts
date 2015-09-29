if vrMeshCmdRoll != undefined do (destroydialog vrMeshCmdRoll)

--theBricks = for o in objects where hasproperty o "filename" and o.filename == "J:\PROJECTS\Strada Unlimited\Ricks Bricks\assets\max\proxy\heroBrickV1.vrmesh" collect o

--press a button, make an array of the objects
-- select a set of objects to scatter to
-- randomly go through the array, pick an object, and transfer it's filename and material to the scattertoObject
-- parse a directory picked byt a button for any tif



-- for changing map level for darkening brick text   map.output.rgb_level = 0.75

theFiles
theFileNames
thisfile
theLbxArray
theBitmapFiles = #()
theObsToScatter = #()

fn selectMeshByFile = (
	
	c = vrMeshCmdRoll.lbx1.selection as array
			theIndex = c[1]
			itm = theFiles[theIndex]
	
	select( for o in objects where hasproperty o "filename" and o.filename == itm collect o)
	
	
)

fn selectMeshByOb = (
	

			itm = selection[1].filename
	
	select( for o in objects where hasproperty o "filename" and o.filename == itm collect o)
	
	
)

	fn makeInstancesOfMats = (
	myInstances = makeInstanceArray()
	
	for i in myInstances do (
		
		myMat = copy i[1].material
		for o in i do (o.material = myMat)
		
		
	)
	
	free myInstances
	
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

fn refSubDivs = (

for i in scenematerials where classof i == VRayMtl do ( i.reflection_subdivs = 24
	print i
	print i.reflection_subdivs
)

)

-----------------------------bitmap changing section

fn findMyBitMaps theOb theName theClass = (--finds a certain map of a certain name in an objects material
	--theBitmap = findMyBitMaps $ "mask" bitmaptexture
			myShit = #()
		myShit += getClassInstances theClass target:theOb
	--print myShit
		for i in myShit where  i.name ==  theName do (return i)--filters for name of map

)

fn ScatterBitmap theOb thisFilename= (
	
	try(theOb.material.texmap_diffuse.mask[2].filename = thisFilename) catch ()
	
	
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


fn getFilesfromDirectory = (
	
	
theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
theDialog.title = "PLEASE Select One Or More Files" --set the title
theDialog.Multiselect = true --allow multiple files to be selected
--theDialog.Filter = "HTML Files (*.html)|*.html|All Files (*.*)|*.*" --specify the filter
--theDialog.FilterIndex = 2 --set the filter drop-down list to All Files
result = theDialog.showDialog() --display the dialog, get result into variable
result.ToString() --when closed, convert the result to string
result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
theBitmapFiles = theDialog.fileNames --the selected filenames will be returned as an array
--update ui 
try (vrMeshCmdRoll.lbx1.items = theFileNames) catch()

return theBitmapFiles
	
	
)

rollout vrMeshCmdRoll "vr mesh commander" width:437 height:468
(
	multiListBox lbx1 "vrmeshes in directory" pos:[19,45] width:150 height:10
	button btn1 "collect vrMeshes in Dir" pos:[16,22] width:155 height:18
	button btn4 "scatter them" pos:[182,47] width:124 height:16
	button btn3 "Select same Wire Color" pos:[182,89] width:124 height:16
	spinner spn1 "scale selected  proxies" pos:[208,112] width:96 height:16 range:[-100,100,0]
 
 

	
	button btn11 "sel all insances of vrmesh" pos:[182,68] width:124 height:16
	GroupBox grp1 "Original Tools" pos:[7,5] width:413 height:207
	button btn13 "capture objects to scatter" pos:[15,236] width:184 height:18
	button fuckBtn "Scatter vrMesh Fnames and inst Mats" pos:[15,261] width:184 height:18
	button selByObBtn "Sel same filename as Selected Ob" pos:[15,286] width:184 height:18
	button selectBmpFilesBtn "Select bitmaps to scatter" pos:[15,311] width:184 height:18
	button scatterBmps "Scatter the bitmaps to selection" pos:[15,337] width:184 height:18
	button btn19 "Make selected materials unique" pos:[15,365] width:184 height:18
	
	
	GroupBox grp3 "Tools" pos:[8,218] width:202 height:236
	button shitBtn "capture objects to scatter" pos:[227,243] width:184 height:18
	button btn22 "Scatter vrMesh Fnames and inst Mats" pos:[227,268] width:184 height:18
	button btn23 "Sel same filename as Selected Ob" pos:[227,293] width:184 height:18
--	button fuckBtn "Select bitmaps to scatterB" pos:[227,318] width:184 height:18
	button darkTextBtn "set darkness level" pos:[304,318] width:113 height:18
	button flipBtn "Flip the bitmap" pos:[235,345] width:168 height:18
	
	
	
	GroupBox grp4 "moreTools" pos:[220,225] width:202 height:236
	
	
	
	spinner darkSpn "" pos:[238,318] width:58 height:16 range:[0,1,1] scale:1
	
	

			
			
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
	on btn13 pressed do
	(theObsToScatter = selection as array
	btn13.text = theObsToScatter.count as string	+ " objects to Scatter"	
		myNames= for i in theObsToScatter collect i.name
		btn13.tooltip = myNames as string)
	on fuckBtn pressed do
	(
			for i in selection where hasproperty i "filename" do (
				myRan = random 1 theObsToScatter.count
				i.filename = theObsToScatter[myRan].filename
				i.material = theObsToScatter[myRan].material
				
				
				)
		)
	on selByObBtn pressed do
	(
			selectMeshByOb()
		)
	on selectBmpFilesBtn pressed do
		(getFilesfromDirectory())
	on scatterBmps pressed do
	(
			for i in selection do (
				
				thisBmp =theBitmapFiles[ random 1 theBitmapFiles.count]
				ScatterBitmap i thisBmp
				)
			
			)
	on btn19 pressed do
	(
			
			for i in selection do (if i.material != undefined do (i.material = copy i.material  )
		)
		
	)
	on shitBtn pressed do
	(theObsToScatter = selection as array
	btn13.text = theObsToScatter.count as string	+ " objects to Scatter"	
		myNames= for i in theObsToScatter collect i.name
		btn13.tooltip = myNames as string)
	on btn22 pressed do
	(
			for i in selection where hasproperty i "filename" do (
				myRan = random 1 theObsToScatter.count
				i.filename = theObsToScatter[myRan].filename
				i.material = theObsToScatter[myRan].material
				
				
				)
		)
	on btn23 pressed do
		(selectMeshByOb())
	on darkTextBtn pressed do
	(
			for i in selection do (
					try(	i.material.texmap_diffuse.mapList[2].map.output.rgb_level = darkSpn.value) catch()
				)
			
			)
	on flipBtn pressed do
	(
			
			for i in selection do (if i.material != undefined do (i.material = copy i.material  )
		)
		
	)
)
	
createDialog vrMeshCmdRoll