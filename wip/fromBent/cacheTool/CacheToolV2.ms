--questions
-- in the random offset button I haveit going from negative the random value to positive the random value...is that correct?
-- the speed factor...what are the reasonable minimum and maximum numbers?
--


--Can we have the cache filename be more global, so when you re-launch the tool it remembers the last one? 
--Not session sticky, but just so if you close the dialog it remembers.
	-- I think for the most part it is now not only session sticky but file sticky...
 
 
-- How about we rename the cache modifier when the "Assign chache file" is used? (Something you hasd suggested.)
	-- i dont think its necessary...I am now using the file names on the modifiers to do that....it is more explicit.
 


--(The crowd system only uses selection sets to manage delegates so being able to create sets from the caches would be very helpful



--rollout init
try (destroyDialog CrowdCacheTools) catch()

--define vars
if  lastPCFileName == undefined then (
	persistant global lastPCFile = "Current\cache\file location\and filename"
	persistant global lastPCFilename = "Current\cache\file location\and filename"
	)
PCFiles
PCFileNames
lastPCfile
lastPCfilename

	if PCsInDir == undefined then(
global PCsInDir = #()
global PCFileNamesInDir = #()
	)
	
	
	
--functions
fn filterPCsInScene = (--finds all objects in scene which have PC mods on them and filters their file locations WITH paths for assignment AND their shortened names
  PCFiles = #()
	PCFilenames = #()
	rawPcObsArray = for i in objects where i.modifiers["Point Cache"] != undefined  collect  i.modifiers["Point Cache"].filename
		for i in rawPcObsArray do (
			thisFileName = fileNameFromPath i
			appendIfUnique PCFiles i
			appendIfUnique PCFileNames thisFileName
			)
			--sort PCFiles
			--sort PCFilenames
		try(CrowdCacheTools.lbx1.items = PCFilenames) catch()
			
		
	)-- end function
--thePc2s
fn getPointCachesInDir = (
			--reinitializing various arrays
			filesarray = #()
		Mydirectory = getFileNamePath lastPCFile
		theFullDirectory = myDirectory +"*.pc2"
		thePC2s = getFiles theFullDirectory
		PCsInDir = thePC2s
		PCFileNamesInDir =  for i in thePC2s collect (fileNameFromPath i)
		crowdCacheTools.lbx2.items = PCFileNamesInDir
		--return filenameArray

)	
	filterPcsInScene()

rollout CrowdCacheTools "Crowd Cache Tools" width:296 height:520
(
	button assignCacheBtn "Assign Cache Modifier" pos:[16,24] width:120 height:24
	button pickCacheFileBtn "Pick Cache File..." pos:[16,56] width:120 height:24
	button assignCacheModBtn "Assign Cache File" pos:[152,56] width:128 height:24
	button commonCacheBtn "Common Cache File" pos:[12,136] width:136 height:24
	button speedByFrameBtn "Calculate" pos:[156,248] width:120 height:24
	button cacheFileGroupsRefreshBtn "Refresh" pos:[192,488] width:88 height:16
	button randomOffsetBtn "Apply Offset" pos:[156,184] width:120 height:24
	spinner offSetFramesSpn "Offset:" pos:[24,188] width:112 height:16 range:[0,100,0] type:#integer
	button selByWireColorBtn "Color" pos:[160,136] width:120 height:24
	GroupBox grp1 "Offset Cache File" pos:[8,168] width:280 height:48
	GroupBox grp2 "Cache Modifier" pos:[8,8] width:280 height:112
	editText currentCacheLbl  pos:[16,88] width:264 height:16 text: lastPCFilename
	GroupBox grp3 "Select By" pos:[8,120] width:280 height:48
	GroupBox grp4 "Playback by Speed" pos:[8,224] width:280 height:56
	spinner speedFactorSpn "Speed Factor:" pos:[48,248] width:100 height:16 range:[0,5,0.025]
	listbox lbx1 "Cache Files in Scene" pos:[8,286] width:140 height:11 items: PCFilenames
	listbox lbx2 "Cache Files in Directory" pos:[152,286] width:140 height:11 items: PCFileNamesInDir
	button createSelSetFromSelectedBtn "Create Selection set from Selected" pos:[8,488] width:180 height:16

	

	
	on assignCacheBtn pressed do
	(
		--ssigns an empty cache file to the selected objects (our rats)
		
				for i in selection do(
					myMod = Point_Cache loadtype: 1
					if i.modifiers["Point Cache"] == undefined do(
						addModifier i myMod
					)
				)
	)
	on pickCacheFileBtn pressed do
	(
			--when pressed, it allows the user to pick a PC2 file and store the filename in memory- also updated the label below with the current point cache filename
			try (f = getOpenFileName types:"Pc2(*.pc2)|") catch()
			if f == undefined or getFilenameType f != ".pc2" then ( 
				messageBox("You did not select a .pc2 file")
				)
				else(
			lastPCFile = f
		lastPCFilename = fileNameFromPath f
		currentCacheLbl.text = lastPCFilename
					getPointCachesInDir()
					
				)
	)
	on assignCacheModBtn pressed do
	(
			--when pressed, it assigns the chosen point cache file to the selected objects.  
			--Also assigns a random color to the selection set for organization reasons.  possibly makes a selection set too.
			--if point no point cache modifier, assign one
					b = fopen currentCacheLbl.text "rb"
			-- Much easier...
			fseek b 16 #seek_set
			pointCount = readLong b
			fclose b
			pointCount
		errorLog = #()

			for i in selection do(
				vertsCount = i.vertices.count
				if vertsCount == pointCount then(
				try(
					i.modifiers["Point Cache"].filename = lastPCFile
				)
				catch(messagebox(i.name + " doesnt have a PC Modifier"))
				)
				else(append errorLog i.name)
					
			)--end for
			
			if errorlog.count != 0 then(messagebox(errorlog as string + "  the PC vert count did not match these objects vert count"))
	)

	on commonCacheBtn pressed do
	(
				
			--the idea was to select a single object with a cache, and have it select all objects in the scene with the same cache file on it.
			myCache = try (selection[1].modifiers["Point Cache"].filename) 
			catch(messagebox("No Point Cache on The Object or no object selected"))
	
			myObs = for i in objects where i.modifiers["Point Cache"] != undefined and i.modifiers["Point Cache"].filename == myCache  collect  i
			select myObs
			theIndex = findItem PCfiles myCache
			print theIndex
			lbx1.selection = theIndex
			
	)
	on speedByFrameBtn pressed do
	(suspendEditing()
		--this runs the "speed by frame" or playback by speed tool 
		--which calculates the speed of the crowd delegate 
		--and sets the playback rate for the cache file to go along with it.  
		--uses the speed factor to amplify the results.
		errorArray = #()
		for i in selection do (
		if i.modifiers["Point Cache"] != undefined and i.parent != undefined then (
		global add_speed
		global temp_speed = 0
		FudgeFactor = speedFactorSpn.value
		RatMesh= i
		DelSelection = i.parent
		RatMesh.modifiers["Point Cache"].playbackType = 3
		  for t = animationrange.start to animationrange.end do
				  (
					
					at time t current_pos = DelSelection.center
					at time (t-1f) last_pos = DelSelection.center
					frame_speed =  ((distance current_pos last_pos)*FrameRate*FudgeFactor)
		
					add_speed = temp_speed + frame_speed
					temp_speed = add_speed
					--format "frame speed %: %\n" t frame_speed
					--format "SpeedAdd %: %\n" t add_speed
					Animate on at time t RatMesh.modifiers[1].playbackFrame = add_speed
				   )
			) --end if
		else (append errorArray i.name)
		)--end for
		
		if errorArray.count != 0 then (messageBox (errorArray as string + "  These objects errored out, might not have a delegate?"))
resumeEditing()
	)--end button

	on randomOffsetBtn pressed do
	(
			--when pressed, it randomly offsets the selected objects cache file using the offset spinner
				try(for i in selection do (i.modifiers["Point Cache"].playbackFrame = random -offsetFramesSpn.value offSetFramesSpn.value))
					catch (
						messageBox("It didn't work, this works on the mesh, not the delegate.")
								)
	)
	on selByWireColorBtn pressed do
	(
			--this is the action item "select by color" most people don't even know you can do that.  useful for selecting a group of objects with the same wirecolor
				try(
				myWire = selection[1].wirecolor
				selWires = for i in objects where i.wirecolor == myWire collect i
					select selWires
					)
				catch(messagebox("No item originally Selected"))
	)

	on lbx1 doubleClicked sel do
	(
			--this shows a list of applied cache files according to the cache file.  not sure how this would work.  needs more thought
			--for o in objects where 
		suspendEditing()
		myItem = sel
		SelObjects = for i in objects where i.modifiers["Point Cache"] != undefined and i.modifiers["Point Cache"].filename == PCFiles[myItem] collect i
			select SelObjects
		resumeEditing()
		
	)
		on lbx2 doubleClicked sel do
	(
			--this shows a list of applied cache files according to the cache file.  not sure how this would work.  needs more thought
			--for o in objects where 
		lastPCFile = PCsInDir[sel]
		currentCacheLbl.text = PCFileNamesInDir[sel]
		
	)

	on cacheFileGroupsRefreshBtn pressed do
	(
		filterPCsInScene()
			
		)
		
		on createSelSetFromSelectedBtn pressed do(
			try(selectionSets[lbx1.selected] = selection as array) catch(messagebox("Nothing Happened...proly cause nothing was selected"))
			
		)

	)
	
	

createDialog CrowdCacheTools