--questions
-- in the random offset button I haveit going from negative the random value to positive the random value...is that correct?



-- I dont think assign Cache modfier button is working.  
--How about we put this option into the assign cache file button and just make sure that the obejct has a point cache modifier?  
--If it doesn't just add one. Then we can remove this button.
 
--Shorten the path of the cache file (or make a larger area to display the path) 
--Throw in a try\catch when no animation file has been choosen
-- I pressed the assign cache file and the default txt ended up in the cache file.

--Can we have the cache filename be more global, so when you re-launch the tool it remembers the last one? 
--Not session sticky, but just so if you close the dialog it remembers.
 
-- Lets make the Speed by Frame tool work on the Rat mesh selections, instead of assuming the delegates are selected.
 
-- How about we rename the cache modifier when the "Assign chache file" is used? (Something you hasd suggested.)
 
--Lets make the listbox select the common objects with the same popnt cache like we talked about.  
--Also, can we add a button to create a set of selection sets out of the list box array? 
--(The crowd system only uses selection sets to manage delegates so being able to create sets from the caches would be very helpful




try (destroyDialog CrowdCacheTools) catch()


if   lastPCFileName == undefined then (global lastPCFileName = "Current\cache\file location\and filename")----messagebox("lasPC is undefined")


fn filterPCs = (
  theFilteredArray = #()
	testObs = for i in objects where i.modifiers["Point Cache"] != undefined  collect  i.modifiers["Point Cache"].filename
		for i in testObs do (
			thisFile = fileNameFromPath i
			appendIfUnique theFilteredArray thisFile)
			sort theFilteredArray
	return theFilteredArray
)

	

rollout CrowdCacheTools "Crowd Cache Tools" width:296 height:520
(
	button assignCacheBtn "Assign Cache Modifier" pos:[16,24] width:120 height:24
	button pickCacheFileBtn "Pick Cache File..." pos:[16,56] width:120 height:24
	button assignCacheModBtn "Assign Cache File" pos:[152,56] width:128 height:24
	button commonCacheBtn "Common Cache File" pos:[16,136] width:120 height:24
	button speedByFrameBtn "Calculate" pos:[156,248] width:120 height:24
	button cacheFileGroupsRefreshBtn "Refresh" pos:[192,488] width:88 height:16
	button randomOffsetBtn "Apply Offset" pos:[156,184] width:120 height:24
	spinner offSetFramesSpn "Offset:" pos:[24,188] width:112 height:16 range:[0,100,0] type:#integer
	button selByWireColorBtn "Color" pos:[160,136] width:120 height:24
	GroupBox grp1 "Offset Cache File" pos:[8,168] width:280 height:48
	GroupBox grp2 "Cache Modifier" pos:[8,8] width:280 height:112
	editText currentCacheLbl  pos:[16,88] width:264 height:16 text: lastPCFileName
 
	GroupBox grp3 "Select By" pos:[8,120] width:280 height:48
	GroupBox grp4 "Playback by Speed" pos:[8,224] width:280 height:56
	spinner speedFactorSpn "Speed Factor:" pos:[24,248] width:112 height:16 range:[0,100,0.25]
	listbox lbx1 "Cache File Groups" pos:[8,288] width:272 height:13 --items:  --#(RunCycle_v07, Walk_v04, Scurry_v01, Scurry_v02)
 --items:  --#(RunCycle_v07, Walk_v04, Scurry_v01, Scurry_v02)
	
--on CrowdCacheTools	currentCacheLbl.text = lastPCFileName	
	
	
	
		
	
	
		
		
		

	
	on assignCacheBtn pressed do
	(
		--ssigns an empty cache file to the selected objects (our rats)
				for i in selection do(
					try (i.modifiers["Point Cache"].filename = "")
					catch(messagebox(i.name + " " + "doesn't have a PC applied"))
					)
		)
	on pickCacheFileBtn pressed do
	(
			--when pressed, it allows the user to pick a PC2 file and store the filename in memory- also updated the label below with the current point cache filename
			f = getOpenFileName types:"Pc2(*.pc2)|"
			currentCacheLbl.text = f
			lastPCFileName = f
	
	
		)
	on assignCacheModBtn pressed do
	(
			--when pressed, it assigns the chosen point cache file to the selected objects.  
			--Also assigns a random color to the selection set for organization reasons.  possibly makes a selection set too.
			--if point no point cache modifier, assign one
			for i in selection do(
				try(
					i.modifiers["Point Cache"].filename = currentCacheLbl.text
				)
				catch(messagebox(i.name + " doesnt have a PC Modifier"))
					
			)
		)
	on commonCacheBtn pressed do
	(
				
			--the idea was to select a single object with a cache, and have it select all objects in the scene with the same cache file on it.
			myCache = try (selection[1].modifiers["Point Cache"].filename) 
			catch(messagebox("No Point Cache on The Object or no object selected"))
	
			myObs = for i in objects where i.modifiers["Point Cache"] != undefined and i.modifiers["Point Cache"].filename == myCache  collect  i
			select myObs
			
		)
	on speedByFrameBtn pressed do
	(
		--this runs the "speed by frame" or playback by speed tool 
		--which calculates the speed of the crowd delegate 
		--and sets the playback rate for the cache file to go along with it.  
		--uses the speed factor to amplify the results.
	for i in selection do (
	global add_speed
	global temp_speed = 0
	FudgeFactor = speedFactorSpn.value
	DelSelection = i
	RatMesh= DelSelection.children[1]
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
	
	)--end for
	)--end button
	on cacheFileGroupsRefreshBtn pressed do
	(
			--this can be used to refresh the listbox above
			 lbx1.items = filterPCs()
			
		)
	on randomOffsetBtn pressed do
	(
			--when pressed, it randomly offsets the selected objects cache file using the offset spinner
				try(for i in selection do (i.modifiers["Point Cache"].playbackFrame = random -offsetFramesSpn.value offSetFramesSpn.value))
					catch(messageBox("It didn't work, this works on the mesh, not the delegate."))
			
		)
	on offSetFramesSpn changed val do
	(
			--this is the offset value is frames that will be used with the apply offset button
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
	on speedFactorSpn changed val do
	(
			--this is the "fudge factor" for the playback by speed tool.  using this the user can dial in the speed of the playback of the cache file
			)
	on lbx1 doubleClicked sel do
	(
			--this shows a list of applied cache files according to the cache file.  not sure how this would work.  needs more thought
			--for o in objects where 
		)
)




createDialog CrowdCacheTools