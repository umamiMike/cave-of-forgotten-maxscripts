--******************************************************************************
--*
--*  PFlow Baker v0.71
--*  by Ofer Zelichover (c) 
--*  Started: 2:06 AM Tuesday, June 19, 2007
--*  http://www.oferz.com  ; maxscripts@oferz.com
--*
--******************************************************************************
--*  You may use this script freely as you see fit.
--*  You may use parts or the script as a whole in your own scripts.
--*  (it would be nice if you give me a creadit if you do so ;))
--******************************************************************************
--*  This script comes with no warranty.
--*  I cannot be held responsible for any loss of data, time or any other
--*  damage or loss due to the use of this code.
--*
--*  ********************************************************************
--*  *** IF YOU DON'T LIKE THE ABOVE STATEMENT, DON'T USE THIS SCRIPT ***
--*  ********************************************************************
--*
--*  **** This script was written for max 9 and above and wasn't tested on other
--*  **** vertions of max.
--*
--*  If you find any bugs in it please let me know.
--******************************************************************************
--* Description
--* -------------
--*  Bakes particle flow particles into helpers / meshes.
--*
--******************************************************************************

try (destroyDialog ro_PflowBaker)catch()

rollout ro_PflowBaker "PFlow Baker"
(
	
	-- Local Struct Definitions
	-----------------------------------------------------------------------------
	
	
	-- A struct to bake animated geometry using PointCache for objects like particles and hair and fur.
	struct s_AnimatedMeshBaker (
		-- Properties
		-------------------------------------------------------------------
		
		-- The new object that will be created will be stored here.
		bakedObject = undefined,
		
		-- This is used to store a reference to the point cache modifier.
		PCModifier = undefined,
		-- This will be used to store the point cache file name.
		PCFilename = undefined,
		
		-- Stores the state of one file per frame for point cache.
		PCOneFilePerFrame = true,
		
		-- This is used to store a reference to the push modifier.
		PushModifier = undefined,
		
		-- Used to signal a break.
		breakSignaled = false,
		
		-- Stores the state of use vertex animation
		useVertexAnimation = false,
		
		-- Stores the ease curve controller, if one was passed during init.
		easeCurveController = undefined,
		
		
		
		-- This will store the function that will be used to get the new mesh.
		-- The reason it is used, is to make it more flexible to use with different
		-- types of objects and geometry.
		-- This function needs to return an object or a triMesh
		-- If the function returns #Cancel, it will stop execution of the bakeRange function
		-- and turn the breakSignaled flag to true.
		getMeshFn = undefined,
		
		-- These paremeters will be passed to the getMeshFn with an optional
		-- paremeter called params (getMeshFn params:getMeshFnParams)
		getMeshFnParams = undefined,
		
		
		-- Stores the bake step.
		bakeStep = 1,
		
		
		
		-- Functions
		-------------------------------------------------------------------
		
		
		-- checks if a character is a digit
		fn isDigit s = (try(findString "0123456789" (s as string) != undefined)catch(false)),
		
		
		-- removes spaces from the beginning and end of a string
		fn removeSpaces s =
		(
			while s[s.count]==" " do s = subString s 1 (s.count-1)
			while s[1] == " " do s = subString s 2 (s.count-1)
			s
		),
		
		
		-- seperates numbers from other characters in a string. returns an array of the different parts.
		fn explodeName s removeSpaces:true =
		(
			local arr=#()
			local tmpStr = ""
			local isNum = try(s_OsLib.isDigit s[1])catch(false)
			for i=1 to s.count do
			(
				local d = isDigit s[i]
				if d != isNum then
				(
					if removeSpaces then tmpStr = try(removeSpaces tmpStr)catch(tmpStr)
					if isNum then tmpStr = tmpStr as integer
					append arr tmpStr
					tmpStr = ""
					isNum = d
				)
				tmpStr += s[i]
			)
			
			if removeSpaces then tmpStr = try(removeSpaces tmpStr)catch(tmpStr)
			if isNum then tmpStr = tmpStr as integer
			if tmpStr!="" then append arr tmpStr
				arr
		),
		
		
		
		-- Returns the frame number from the filename
		fn getFrameNumberFromFilename filename =
		(
			local regEx = dotNetClass "System.Text.RegularExpressions.RegEx"
			if regEx != undefined then (
				local pattern = "\\.*Frame(\\d+)"
				local matchOption = (dotNetClass "System.Text.RegularExpressions.RegexOptions").IgnoreCase
				local match = regEx.match filename pattern matchOption
				match.Groups.Item[match.Groups.Count - 1].Value as integer
			) else (
				local explodedName = explodeName filename
				explodedName[explodedName.count]
			)
		),
		
		
		
		-- Returns an array with the first and last frames of the point cache files.
		-- This is only for point cache with file per frame, as it gets the actual frame range
		-- by checking the file names.
		fn getPointCacheFrameRange dir: =
		(
			-- If dir is not supplied, then use the dir from struct's PCFilename
			if dir == unsupplied then
				dir = getFilenamePath PCFilename
			
			-- Generate the wildcard file name
			local wildcardName = dir + getFilenameFile PCFilename + "Frame*.mc"
			-- Get the point cache .mc files.
			local files = getFiles wildcardName
			-- Initialize the frames array
			local frames = #()
			-- Loop through the file names
			for f in files do (
				-- Explode the file name to get an array seperating the text from the numbers
				local frame = getFrameNumberFromFilename (getFilenameFile f)
				append frames frame
			)
			#(amin frames, amax frames)
		),
		
		
		
		
		-- Fix the point cache's XML file to include the right frame range (based on the actual saved files in the folder).
		fn fixPointCacheXMLFile =
		(
			-- Get the filename from the point cache modifier.
			local fileName = PCModifier.filename
			
			-- If the file doesn't exist or if it's not a XML file then exit and return false.
			if not doesFileExist filename or not matchPattern (getFilenameType filename) pattern:".XML" then 
				return false
			
			
			-- Get the folder of the file
			local dir = getFilenamePath filename
			
			-- Get the frame range from the files.
			local frameRange = getPointCacheFrameRange dir:dir
			
			
			-- Load the XML file into a dotNet xmlDocument
			local xmlDoc = dotNetObject "system.xml.xmlDocument"
			xmlDoc.Load fileName
			
			
			-- Read timePerFrame value from the XML file.
			local nodes = xmlDoc.SelectNodes "//cacheTimePerFrame[@TimePerFrame]"
			local timePerFrame = (nodes.Item[0].Attributes.GetNamedItem "TimePerFrame").Value as integer
			
			
			-- Change the range attribute in the time node.
			local nodes = xmlDoc.SelectNodes "//time[@Range]"
			local rangeStr = (frameRange[1] * timePerFrame) as string + "-" + (frameRange[2] * timePerFrame) as string
			for i = 0 to (nodes.Count - 1) do (
				local node = nodes.Item[i]
				(node.Attributes.GetNamedItem "Range").Value = rangeStr
			)
			
			-- Change the start and end frames in the channel nodes
			local nodes = xmlDoc.SelectNodes "//Channels/*"
			local startFrame = (frameRange[1] * timePerFrame) as string 
			local endFrame = (frameRange[2] * timePerFrame) as string
			for i = 0 to (nodes.Count - 1) do (
				local node = nodes.Item[i]
				(node.Attributes.GetNamedItem "StartTime").Value = startFrame
				(node.Attributes.GetNamedItem "EndTime").Value = endFrame
			)
			
			
			-- Save the XML into the file.
			xmlDoc.save fileName
			
			
			-- Set the time range for the point cache modifier.
			PCModifier.recordStart = frameRange[1]
			PCModifier.recordEnd = frameRange[2]
			
			-- Reload the point cache
			max modify mode
			modPanel.setCurrentObject PCModifier
			cacheOps.Reload PCModifier
			
			-- Return true for success
			return true
		),
		
		
		
		
		-- Assign an ease curve to the baked object
		fn assignEaseCurve easeCurve =
		(
			undo off with redraw off (
				if not useVertexAnimation then (
					PCModifier.playbackType = 3
					local pcFrameCont = bezier_float()
					local k = addNewKey pcFrameCont PCModifier.recordStart
					k.value = PCModifier.recordStart
					k.inTangentType = k.outTangentType = #linear
					local k = addNewKey pcFrameCont PCModifier.recordEnd
					k.value = PCModifier.recordEnd
					k.inTangentType = k.outTangentType = #linear
					addEaseCurve pcFrameCont easeCurve
					PCModifier.playbackFrame.controller = pcFrameCont
				) else (
					if isKindOf bakedObject.baseObject.mesh[1].object Master_Point_Controller then
						addEaseCurve bakedObject.baseObject.mesh[1].controller easeCurve
				)
			)
		),
		
		
		
		
		
		
		-- Adds an animated push modifier to fool point cache to think the object 
		-- is changing. The animation doesn't really affect the object, as the push values
		-- in both keys are 0
		fn addPushModifier =
		(
			-- If the morpher modifier doesn't exist, create a new one.
			if PushModifier == undefined then (
				-- Create a new morpher modifier
				PushModifier = Push()
				
				-- Assign a new controller to the push value
				PushModifier.Push_Value.controller = linear_float()
				-- Create 2 keys to animate that channel
				local k1 = addNewKey PushModifier.Push_Value.controller -1e5
				k1.value = 0
				local k2 = addNewKey PushModifier.Push_Value.controller 1e5
				k2.value = 0
				
				-- Add the modifier to newObj
				addModifier bakedObject PushModifier
			)
			
			-- Return the push modifier
			return PushModifier
		),
		
		
		
		-- Adds a point cache modifier to the given object.
		-- dir is the directory that will be used to save the pointCache files.
		-- If the directory doesn't exist, it will be created.
		-- If pointCachePerFrame is set to true (the default) it will save a file for each frame. Otherwise
		-- it will save a single file.
		-- Step is the step size for the pointCache.
		fn addPointCacheModifier pointCachePerFrame:true =
		(
			-- Create a new point cache modifier
			if PCModifier == undefined then
				PCModifier = Point_Cache()
			
			-- Set it to one file per frame
			PCModifier.fileCount = 1
			
			-- Create the directory
			makeDir (getFilenamePath PCFilename)
			-- Set the point cache filename.
			PCModifier.filename = PCFilename
			
			-- Set the step size
			PCModifier.sampleRate = bakeStep
			
			-- Add the modifier to the object
			addModifier bakedObject PCModifier
			
			-- Return the new modifier
			return PCModifier
		),
		
		
		
		-- Animates the vertices of destObj to have the positions of the verts in srcTriMesh
		fn animateVertices destObj srcTriMesh =
		(
			if srcTriMesh.numVerts != destObj.baseObject.mesh.numVerts then 
				destObj.mesh = srcTriMesh
			
			animateVertex destObj #all
			local getVertFn = meshOp.getVert --getVert
			undo off (
				for v = 1 to destObj.numVerts do (
					local p = getVertFn srcTriMesh v node:destObj
					animate on 
						destObj.baseObject.mesh[1][v].value = p
				)
				update destObj
				gc light:true
			)
		),
		
		
		
		
		-- Records a single frame in the point cache.
		fn recordPointCacheFrame =
		(
			-- Make sure bakedObject is properly initialize and has a point cache modidifer.
			if PCModifier != undefined then (
				-- Set the point cache's start record time to the current slideTime
				PCModifier.recordStart = sliderTime
				-- Set the point cache's end record time to the current slideTime
				PCModifier.recordEnd = sliderTime
				
				-- Perform point cache record.
				cacheOps.RecordCache PCModifier
			)
		),
		
		
		
		-- Converts a file per frame point cache modifier into a single file point cache
		fn convertPerFrameFileToSingleFile =
		(
			-- Add a new point cache modifier
			local newPCMod = pointCache()
			-- Set the properties for the new point cache
			newPCMod.filename = getFilenamePath PCModifier.filename + getFilenameFile PCModifier.filename + ".pc2"
			newPCMod.recordStart = PCModifier.recordStart
			newPCMod.recordEnd = PCModifier.recordEnd
			newPCMod.fileCount = 0
			
			-- Add the new PC to the bakedObject
			addModifier bakedObject newPCMod
			
			-- Perform point cache record.
			cacheOps.RecordCache newPCMod
			
			
			-- Delete the first point cache modifier
			deleteModifier bakedObject PCModifier
			
			-- Assign the new PC modifier to the struct's PCModifier
			PCModifier = newPCMod
			
			-- Delete the files 
			local files = join #(PCFilename) (getFiles (getFilenamePath PCFilename + getFilenameFile PCFilename + "Frame*.mc"))
			for f in files do
				deleteFile f
		),
		
		
		
		-- Bakes a single frame.
		fn bakeFrame atFrame:sliderTime =
		(
			-- First, if atFrame is differenct than the silderTime, move the silder to that time
			-- so we'll capture the right frame.
			if atFrame != sliderTime then
				sliderTime = atFrame
			
			-- Get the new mesh using getMeshFn
			-- newMesh is the new mesh to be assigned to the bakedObject. It can be and object or a triMesh.
			local newMesh = getMeshFn params:getMeshFnParams
			
			-- If getMeshFn returned #Cancel, that means we want to break.
			if newMesh == #Cancel then (
				breakSignaled = true
				return false
			)
			
			-- If getMeshFn returned undefined, that means we don't have a mesh to bake, so we exit.
			if newMesh == undefined then (
				return false
			)
			
			
			-- If newMesh is not a triMesh, convert it to a triMesh
			if not isKindOf newMesh TriMesh then
				newMesh = snapshotAsMesh newMesh
			
			-- If useVertexAnimation is true, then save the new mesh as vertex animation
			if useVertexAnimation then (
				animateVertices bakedObject newMesh
			) else ( -- Otherwise, store it with the point cache modifier.
				-- Set the newMesh to be the new mesh of bakedObject
				bakedObject.baseObject.mesh = newMesh
				update bakedObject
				
				-- And finally, record the frame in point cache.
				recordPointCacheFrame()
			)
		),
		
		
		
		-- Bakes a range of fraems.
		fn bakeRange startFrame:animationRange.start endFrame:animationRange.end =
		(
			breakSignaled = false
			for f = startFrame to endFrame by bakeStep where not breakSignaled  do
				bakeFrame atFrame:f
		),
		
		
		
		-- Initialize the struct's properties
		fn init getMeshFunc PCDir getMeshFuncParams:undefined \
									newObjName:(uniqueName "BakedObject") \
									pointCachePerFrame:true PCStep:1 \
									useVertAnim:false \
									easeCurve:undefined \
									wireColor: =
		(
			-- Initialize some struct parameters
			breakSignaled = false
			useVertexAnimation = useVertAnim
			if isController easeCurve then
				easeCurveController = easeCurve
			
			-- Store getMeshFunc in the struct's getMeshFn
			getMeshFn = getMeshFunc
			getMeshFnParams = getMeshFuncParams
			
			-- Store the bake step
			bakeStep = PCStep
			
			-- Store one file per frame state
			PCOneFilePerFrame = pointCachePerFrame
			
			-- If pointCachePerFrame is true, set the point cache file name
			-- use a sub dir. with the new object's name.
			-- Otherwise, just use the PCDir
			if pointCachePerFrame then (
				-- Set the file name to use.
				PCFilename = PCDir + newObjName + "\\" + newObjName + ".xml"
			) else (
				-- Set the file name to use.
				PCFilename = PCDir + newObjName + ".xml"
			)
			
			-- Create the new baked object
			bakedObject = mesh name:newObjName
			
			
			-- If useVertexAnimation is false that means we're using point cache,
			-- so add the push and pointcache modifiers.
			if not useVertexAnimation then (
				-- Add a push modifier
				addPushModifier()
				
				-- Add the point cache modifier
				addPointCacheModifier pointCachePerFrame:pointCachePerFrame
			)
			
			if isKindOf wireColor color then
				bakedObject.wireColor = wireColor
		),
		
		
		
		-- Finalize the bake.
		fn done =
		(
			if not useVertexAnimation then (
				-- Delete the push modifier.
				deleteModifier bakedObject PushModifier
				
				-- If the point cache file is an XML file, fix the range in it.
				if matchPattern (getFilenameType PCModifier.filename) pattern:".xml" then
					fixPointCacheXMLFile()
				
				-- If PCOneFilePerFrame is false, convert the point cache to a single file
				if not PCOneFilePerFrame then (
					convertPerFrameFileToSingleFile()
				)
			)
			
			-- Assign the ease curve, if there is one
			if isController easeCurveController then
				assignEaseCurve easeCurveController
		)
		
		
		
	) -- end of s_AnimatedMeshBaker struct
	
	
	
	
	-- This struct is used to store the items in bakedPoints.
	struct s_BakedItem (
		bakedTransObj,  -- Holds the object that has the baked transformation
		meshBaker 		-- Holds an instance of s_AnimatedMeshBaker
	) -- end of s_BakedItem
	
	
	
	
	-- Local Variable Declerations
	-------------------------------------------
	local sources = for o in objects where isKindOf o PF_Source collect o
	local pointCacheDir = ""
	local pointCachePerFramePossible = (isProperty (point_cache()) #fileCount)
	local pointCachePerFrame = pointCachePerFramePossible
	local advancedOptionsVisible = false
	local advancedOptionsControls = #()




	-- User Interface
	-------------------------------------------
	groupBox gbPFlowSelection "PFlow to bake: " width:150 height:45 pos:[5,5]
		dropDownList ddlPflowSource "" width:140 pos:(gbPFlowSelection.pos + [5,17])
	
	groupBox gbTimeControl "Time Control: " width:150 height:123 pos:[5, gbPFlowSelection.pos.y + gbPFlowSelection.height + 5]
		radioButtons rbTimeRange "" labels:#("Active time segment.", "Custom range:") columns:1 pos:(gbTimeControl.pos + [5,17])
		spinner spCustTimeStart "Start: " width:70 fieldWidth:45 type:#integer align:#right range:[animationRange.start, animationRange.end, animationRange.start] enabled:false pos:(rbTimeRange.pos + [40,35])
		spinner spCustTimeEnd "End: " width:70 fieldWidth:45 type:#integer align:#right offset:[-180,0] range:[animationRange.start, animationRange.end, animationRange.end] enabled:false pos:(rbTimeRange.pos + [40,55])
		spinner spStep "Step: " range:[1,1000,1] fieldWidth:45 type:#integer align:#left offset:[0,5]
	
	groupBox gbBakedObject "Baked Object: " width:150 height:115 pos:[5, gbTimeControl.pos.y + gbTimeControl.height + 5]
		radioButtons rbBakedObjMode "" labels:#("Mesh", "Helper", "Mesh and Helper") columns:1 pos:(gbBakedObject.pos + [5,17])
		colorPicker cpWireColor "Wire Color: " color:yellow
		checkbox cbAnimateVisibility "Animate Visibility" checked:true
	
	groupBox gbPostBake "Post Bake: " width:150 height:80 pos:[5, gbBakedObject.pos.y + gbBakedObject.height + 5]
		checkbox cbPostTurnOffPF "Turn off baked PF" checked:true pos:(gbPostBake.pos + [5,17])
		checkbox cbPostSaveBefre "Save a new version" checked:true offset:[-3,0]
		checkbox cbPostShutDown "Shutdown computer" checked:false tooltip:"Shutdown the computer when finished baking." offset:[-3,0]
	
	groupBox gbAnimatedMesh "" width:380 height:173 pos:(gbPFlowSelection.pos + [(gbPFlowSelection.pos.x + gbTimeControl.width + 5), 0])
		checkbox cbAnimatedMesh "Animated Mesh: " checked:false pos:(gbAnimatedMesh.pos + [7,0])
		label lblAnimatedMeshWarning "WARNING !!!\n Using animated mesh can lead to HUGH files and memory consumption, and can increase baking time significantly." align:#left height:40 width:(gbAnimatedMesh.width - 10) pos:(gbAnimatedMesh.pos + [5,19])
		radioButtons rbAnimatedMeshType "How to store:" labels:#("Vertex Animation", "Point Cache Modifier") default:2 enabled:cbAnimatedMesh.checked columns:1 pos:(lblAnimatedMeshWarning.pos + [0,46])
		radioButtons rbAnimatedMeshPCFileType "" labels:#("Single file per object", "File per frame per object") default:(if pointCachePerFramePossible then 2 else 1) enabled:(pointCachePerFramePossible and cbAnimatedMesh.checked) columns:1 pos:(rbAnimatedMeshType.pos + [20, 33])
		button bnAnimatedMeshDir "Choose Point Cache Dir." width:(gbAnimatedMesh.width - 10) enabled:cbAnimatedMesh.checked tooltip:"No folder selected. After you select a folder, this tool tip will show the selected folder." pos:(rbAnimatedMeshType.pos + [0,65])

	groupBox gbEaseCurve "" width:gbAnimatedMesh.width height:285 pos:(gbAnimatedMesh.pos + [0, gbAnimatedMesh.height + 5])
		checkbox cbApplyEaseCurve "Apply Ease Curve: " pos:(gbEaseCurve.pos + [7,0])
		CurveControl crvEaseCurve "" width:(gbEaseCurve.width - 10) height:(gbEaseCurve.height - 30) pos:(gbEaseCurve.pos + [5,17]) enabled:cbApplyEaseCurve.checked \
						x_range:[animationRange.start, animationRange.end] y_range:[animationRange.start, animationRange.end] numCurves:1

	button bnadvancedOptions ">>" width:150 height:18 pos:(gbPostBake.pos + [0, gbPostBake.height + 5]) tooltip:"Show Advanced Options"

	button bnBake "Bake" width:150 height:50 pos:(bnadvancedOptions.pos + [0, 30])


	
	-- Functions
	-------------------------------------------
	fn leadingZero n i =
	(
		local n = n as string
		while n.count < i do
			n = "0" + n
		n
	)

	-- checks if a character is a digit
	fn isDigit s = (try(findString "0123456789" (s as string) != undefined)catch(false))


	-- removes spaces from the beginning and end of a string
	fn removeSpaces s =
	(
		while s[s.count]==" " do s = subString s 1 (s.count-1)
		while s[1] == " " do s = subString s 2 (s.count-1)
		s
	)

	
	fn truncFileDisplay str l = (
		if (getTextExtent str).x <= l then return str
		local fName = "\\" + filenameFromPath str
		local fPath = getFilenamePath str
		local explodedPath = filterString fPath "\\"
		if fName == "" or fName == "\\" then (
			fName = "\\" + explodedPath[explodedPath.count] + "\\"
			local cnt = (explodedPath.count - 1)
		) else
			local cnt = explodedPath.count
		fPath = explodedPath[1]
		for i = 2 to cnt do
			fPath += "\\" + explodedPath[i]
		local returnStr = fPath + "..." + fName
		while (((getTextExtent returnStr).x > l) AND (fPath.count > 0)) do (
			fPath = subString fPath 1 (fPath.count-1)
			returnStr = fPath + "..." + fName
		)
		returnStr
	)

	-- seperates numbers from other characters in a string. returns an array of the different parts.
	fn explodeName s removeSpaces:true =
	(
		local arr=#()
		local tmpStr = ""
		local isNum = try(s_OsLib.isDigit s[1])catch(false)
		for i=1 to s.count do
		(
			local d = isDigit s[i]
			if d != isNum then
			(
				if removeSpaces then tmpStr = try(removeSpaces tmpStr)catch(tmpStr)
				if isNum then tmpStr = tmpStr as integer
				append arr tmpStr
				tmpStr = ""
				isNum = d
			)
			tmpStr += s[i]
		)
		
		if removeSpaces then tmpStr = try(removeSpaces tmpStr)catch(tmpStr)
		if isNum then tmpStr = tmpStr as integer
		if tmpStr!="" then append arr tmpStr
 			arr
	)
	
	
	fn ccCurveToBezierFloat curve =
	(
		local cont = bezier_float()
		local cnt = curve.points.count
		local tickPerFrame = 1. / (1t).frame as float
		for i = 1 to cnt do (
			local p = curve.points[i]
			k = addNewKey cont p.value.x
			k.value = p.value.y * tickPerFrame
			k.x_locked = false
			k.freeHandle = true
			local mult = 5.337
			k.inTangentType = #custom
			k.outTangentType = #custom
			k.inTangent = if p.inTangent.x != 0 then ( ((p.inTangent.y * tickPerFrame) / (abs p.inTangent.x)) / mult) else 0
			k.outTangent = if p.outTangent.x != 0 then ( ((p.outTangent.y * tickPerFrame) / (abs p.outTangent.x)) / mult) else 0
			k.inTangentLength = length p.inTangent
			k.outTangentLength = length p.outTangent
		)
		cont
	)
	
	
	
	fn assignEaseCurve bakedPoints easeCurve =
	(
		undo off (
			with redraw off (
				local canceled = false
				progressStart "Applying ease curve..."
				local cnt = bakedPoints.count as float
				for i = 1 to (cnt as integer) where not canceled and bakedPoints[i] != undefined do (
					local o = bakedPoints[i].bakedTransObj
					addEaseCurve o.transform.controller easeCurve
					addEaseCurve o.visibility.controller easeCurve
					
					canceled = not (progressUpdate ((i / cnt) * 100))
				)
				progressEnd()
			)
		)
	)
	
	
	-- Define the getMeshFunc for use with s_AnimatedMeshBaker
	fn getMeshFunc params: =
	(
		-- Get the particle flow object from params (for better code readability)
		local pf = params[1]
		
		-- Get the particle id from params (for better code readability)
		local id = params[2]
		
		-- Return the mesh
		pf.getParticleShapeByID id
	)
	
	
	-- mode: #helper, #mesh, #both
	-- vertexAnimMode: #None, #vertexAnim, #PointCache
	fn bakeParticles pf rangeStart:animationRange.start rangeEnd:animationRange.end step:1 mode:#mesh animateVisibility:true vertexAnimMode:#None col:yellow easeCurve:undefined pointCachePerFrame:true = 
	(
		local canceled = false
		local tRange = (rangeEnd - rangeStart) as integer
		tRange = tRange as float / step
		local bakedPoints = #()
		max create mode
		progressStart "Baking particles..."
		for f = rangeStart to rangeEnd by step where not canceled do (
			sliderTime = f
			canceled = not (progressUpdate ((f / tRange) * 100))
			local cnt = pf.numParticles()
			for n = 1 to cnt where not canceled do (
				canceled = getProgressCancel()
				if canceled then exit
				
				local i = pf.getParticleID n
				
				
				
				if pf.getParticleAgeByID i > 0f then (
					-- Get the particle transform.
					local tm = pf.getParticleTMByID i
					
					-- If bakedPoints[i] is undefiend, that means this particle was not initialize before, so
					-- first we need to initialize it.
					if bakedPoints[i] == undefined then (
						-- Create a new s_BakedItem instance
						bakedPoints[i] = s_BakedItem()
						
						-- If a point helper is needed (modes #mesh or #both) then create it.
						if mode == #helper or mode == #both then (
							local helperObj = point name:("BakedParticle_" + leadingZero i 3) cross:on box:on size:5 wireColor:col transform:tm
						)
						
						
						local meshObj = undefined
						
						-- If a mesh should be also baked, create a new instance of s_AnimatedMeshBaker
						if mode == #mesh or mode == #both then (
							
							-- If vertexAnimMode is not none, then create a baker.
							if vertexAnimMode != #none then (
								-- Create a new instace of s_AnimatedMeshBaker
								bakedPoints[i].meshBaker = s_AnimatedMeshBaker()
								
								-- Init the meshBaker
								bakedPoints[i].meshBaker.init getMeshFunc pointCacheDir getMeshFuncParams:#(pf, i) \
																newObjName:("BakedParticleMesh_" + leadingZero i 3) \
																pointCachePerFrame:pointCachePerFrame \
																PCStep:step \
																useVertAnim:(vertexAnimMode == #vertexAnim) \
																easeCurve:easeCurve \
																wireColor:col
								meshObj = bakedPoints[i].meshBaker.bakedObject
								meshObj.transform = tm
							) else (
								-- Create a snapshot of the particle mesh.
								local meshObj = mesh transform:tm name:("BakedParticleMesh_" + leadingZero i 3) wireColor:col
								meshObj.mesh = pf.getParticleShapeByID i
							)
						)
						
						
						-- Assign the transform baked object to bakedPoints[i].bakedTransObj
						if mode == #helper or mode == #both then (
							bakedPoints[i].bakedTransObj = helperObj
							if isValidNode meshObj then
								meshObj.parent = helperObj
						) else
							bakedPoints[i].bakedTransObj = meshObj
						
						
						-- Init visibility animation.
						if animateVisibility then (
							bakedPoints[i].bakedTransObj.visibility = bezier_float()
							bakedPoints[i].bakedTransObj.visibility.controller.value = 0
							at time (f - 1t) animate on 
								bakedPoints[i].bakedTransObj.visibility.controller.value = 0
							animate on
								bakedPoints[i].bakedTransObj.visibility.controller.value = 1
						)
					) -- End of particle bake init.
					
					
					-- Bake the particle's transform
					animate on
						bakedPoints[i].bakedTransObj.transform = tm
					
					-- If we need to bake the mesh animation, bake it now using s_AnimatedMeshBaker's bakeFrame method.
					if vertexAnimMode != #None and (mode == #mesh or mode == #both) then (
						bakedPoints[i].meshBaker.bakeFrame atFrame:sliderTime
						
						-- If the bake was canceled then set canceled to true
						if bakedPoints[i].meshBaker.breakSignaled then
							canceled = true
					)
				)
			)
			
			
			-- Animate the particles off visibility, if needed.
			if animateVisibility then (
				for i = 1 to bakedPoints.count where bakedPoints[i] != undefined and bakedPoints[i].bakedTransObj.visibility and pf.getParticleIndex i == 0 do (
					at time (f - 1t) animate on
						bakedPoints[i].bakedTransObj.visibility.controller.value = 1
					animate on
						bakedPoints[i].bakedTransObj.visibility.controller.value = 0
				)
			)
			
			gc light:true
		)
		progressEnd()
		
		-- Make all the visibility keys stepped
		if animateVisibility then (
			for o in bakedPoints do (
				for k in o.bakedTransObj.visibility.controller.keys do 
					k.inTangentType = k.outTangentType = #Step
			)
		)
		
		-- Finalize mesh animation
		if vertexAnimMode != #none then (
			for i = 1 to bakedPoints.count where bakedPoints[i] != undefined and bakedPoints[i].meshBaker != undefined do
				bakedPoints[i].meshBaker.Done()
		)
		
		
		-- Apply ease curve
		if easeCurve != undefined then
			assignEaseCurve bakedPoints easeCurve
		
		
		
		-- Clean up
		bakedPoints = #()
		gc light:true
		forceCompleteRedraw()
	)
	
	
	
	
	
	
	fn saveNewVersion =
	(
		if maxFileName == "" then
			baseName = "PFlowBaker_Baked_01"
		else
			baseName = getFilenameFile maxFileName
		local filename = ""
		if matchPattern baseName pattern:"*_Baked_??" then (
			local explodedName = explodeName baseName
			if isKindOf explodedName[explodedName.count] integer then (
				local ver = explodedName[explodedName.count]
				local baseName = subString baseName 1 (baseName.count - 2)
				local maxVer = 100
				do (
					filename = maxFilePath + baseName + leadingZero ver 2 + ".max"
					ver += 1
				) while ver < maxVer and doesFileExist filename
			) else
				filename = maxFilePath + baseName + "_Baked_01.max"
		) else
			filename = maxFilePath + baseName + "_Baked_01.max"
format "Saving new version as: %\n" filename
		saveMaxFile filename quiet:true
	)
	
	
	fn shutDownComputer =
	(
		local cmd = "shutdown -s -f -t 300 -c \"Finished backing PFlow. Shutting down in 5 minutes.\""
		dosCommand cmd
		quitMax #noPrompt
	)

	
	fn getBakedObjectMode =
	(
		case rbBakedObjMode.state of (
			1: #mesh
			2: #helper
			3: #both
		)
	)
	
	fn getVertexAnimMode =
	(
		if cbAnimatedMesh.checked then (
			case rbAnimatedMeshType.state of (
				1: #VertexAnim
				2: #PointCache
			)
		) else 
			#None
	)
	
	
	fn showHideAdvancedOptions =
	(
		for c in advancedOptionsControls do
			c.visible = advancedOptionsVisible
		ro_PflowBaker.width = if advancedOptionsVisible then 550 else 160
		zoom crvEaseCurve #all
	)
	
	
	fn updateCurveControlRanges =
	(
		local pointVals = for p in crvEaseCurve.curves[1].points collect (p.value - crvEaseCurve.y_range[1]) / (crvEaseCurve.y_range[2] - crvEaseCurve.y_range[1])
		if rbTimeRange.state == 2 then 
			local range = [spCustTimeStart.value, spCustTimeEnd.value]
		else
			local range = [animationRange.start, animationRange.end]
		
		crvEaseCurve.x_range = range
		crvEaseCurve.y_range = range
		
		for p = 1 to crvEaseCurve.curves[1].points.count do 
			crvEaseCurve.curves[1].points[p].value = crvEaseCurve.y_range[1] + ( pointVals[p] * (crvEaseCurve.y_range[2] - crvEaseCurve.y_range[1]) )
		zoom crvEaseCurve #all
	)
	
	
	fn initCurveControl =
	(
		crvEaseCurve.numCurves = 1
		local curve = crvEaseCurve.curves[1]
		curve.width = 2
		curve.disabledWidth = 1
		curve.disabledColor = gray
		curve.numPoints = 2
		curve.points[1].value = [crvEaseCurve.x_range.x, crvEaseCurve.y_range.x]
		curve.points[2].value = [crvEaseCurve.x_range.y, crvEaseCurve.y_range.y]
		updateCurveControlRanges()
	)
	
	
	fn updateUI withPFSelection:true =
	(
		sources = for o in objects where isKindOf o PF_Source collect o
		ddlPflowSource.items = for o in sources collect o.name
		if withPFSelection then (
			for o in selection where sel == undefined and isKindOf o PF_Source do
				sel = o
			sel = findItem sources sel
			ddlPflowSource.selection = if sel == 0 then 1 else sel
		)
		
		spCustTimeStart.enabled = rbTimeRange.state == 2
		spCustTimeEnd.enabled = rbTimeRange.state == 2
		
		
		gbAnimatedMesh.enabled = advancedOptionsVisible and rbBakedObjMode.state != 2
		lblAnimatedMeshWarning.enabled = gbAnimatedMesh.enabled
		cbAnimatedMesh.enabled = gbAnimatedMesh.enabled
		rbAnimatedMeshType.enabled = gbAnimatedMesh.enabled and cbAnimatedMesh.checked
		bnAnimatedMeshDir.enabled = gbAnimatedMesh.enabled and cbAnimatedMesh.checked and rbAnimatedMeshType.state == 2
		rbAnimatedMeshPCFileType.enabled = gbAnimatedMesh.enabled and cbAnimatedMesh.checked and rbAnimatedMeshType.state == 2 and pointCachePerFramePossible
		
		gbEaseCurve.enabled = advancedOptionsVisible
		cbApplyEaseCurve.enabled = gbEaseCurve.enabled
		crvEaseCurve.enabled = gbEaseCurve.enabled and cbApplyEaseCurve.checked
		
		bnadvancedOptions.text = if advancedOptionsVisible then "<<" else ">>"
		bnadvancedOptions.toolTip = (if advancedOptionsVisible then "Hide" else "Show") + " advanced options."
	)
	
	
	fn openDialog =
	(
		createDialog ro_PflowBaker width:160
	)
	
	
	fn init =
	(
		initCurveControl()
		
		advancedOptionsVisible = false
		advancedOptionsControls = #( gbAnimatedMesh, lblAnimatedMeshWarning, cbAnimatedMesh,
										rbAnimatedMeshType, rbAnimatedMeshPCFileType, bnAnimatedMeshDir,
										gbEaseCurve, cbApplyEaseCurve, crvEaseCurve )
		showHideAdvancedOptions()
		updateUI()
		
		local sel = undefined
		bnBake.enabled = ddlPflowSource.selection > 0
	)
	
	
	-- Event Handlers
	-------------------------------------------
	on ddlPflowSource selected item do (
		bnBake.enabled = item > 0
	)
	
	on rbTimeRange changed state do (
		updateCurveControlRanges()
		updateUI()
		spCustTimeStart.range = [animationRange.start, animationRange.end, spCustTimeStart.value]
		spCustTimeEnd.range = [animationRange.start, animationRange.end, spCustTimeEnd.value]
	)
	
	on spCustTimeStart changed val do (
		if spCustTimeEnd.value <= val then
			spCustTimeEnd.value = val + 1
		updateCurveControlRanges()
	)
	on spCustTimeEnd changed val do (
		if spCustTimeStart.value >= val then
			spCustTimeStart.value = val - 1
		updateCurveControlRanges()
	)

	on rbBakedObjMode changed state do updateUI()
	
	on cbAnimatedMesh changed state do updateUI()
	on rbAnimatedMeshType changed state do updateUI()
	
	on bnAnimatedMeshDir pressed do (
		local dir = getSavePath caption:"Select folder for point cache files" initialDir:pointCacheDir
		if dir != undefined then (
			if dir[dir.count] != "\\" then
				dir += "\\"
			pointCacheDir = dir
			bnAnimatedMeshDir.toolTip = dir
			bnAnimatedMeshDir.text = truncFileDisplay dir (gbAnimatedMesh.width - 20) --"Change Point Cache Dir." 
		)
	)
	
	on cbApplyEaseCurve changed state do updateUI()
	
	on crvEaseCurve reset ci do initCurveControl()
	
	on bnadvancedOptions pressed do (
		advancedOptionsVisible = not advancedOptionsVisible
		showHideAdvancedOptions()
		updateUI()
	)
	
	on bnBake pressed do (
		pointCachePerFrame = pointCachePerFramePossible and rbAnimatedMeshPCFileType.state == 2
		local mode = getBakedObjectMode()
		local vertexAnimMode = getVertexAnimMode()
		if cbAnimatedMesh.checked and (mode == #mesh or mode == #both) \
					and vertexAnimMode == #PointCache and not doesFileExist pointCacheDir then (
			messageBox "The point cache folder does not exist.\nPlease select a different folder."
		) else if not isValidNode sources[ddlPflowSource.selection] then (
			updateUI()
			messageBox "The particle flow you selected was not valid.\nPlease select a particle flow again." title:"PFlowBaker"
		)else (
			local rangeStart = if rbTimeRange.state == 1 then animationRange.start.frame else spCustTimeStart.value 
			local rangeEnd = if rbTimeRange.state == 1 then animationRange.end.frame else spCustTimeEnd.value
			local easeCurveCont = ccCurveToBezierFloat crvEaseCurve.curves[1]
			local easeCurve = if cbApplyEaseCurve.checked then easeCurveCont else undefined
			bakeParticles sources[ddlPflowSource.selection] rangeStart:rangeStart rangeEnd:rangeEnd step:spStep.value mode:mode animateVisibility:cbAnimateVisibility.state vertexAnimMode:vertexAnimMode col:cpWireColor.color easeCurve:easeCurve pointCachePerFrame:pointCachePerFrame
			
			-- Post bake processes
			if cbPostTurnOffPF.checked then
				sources[ddlPflowSource.selection].Enable_Particles = false
			if cbPostSaveBefre.checked then
				saveNewVersion()
			if cbPostShutDown.checked then
				shutDownComputer()
		)
	)
	
	on ro_PflowBaker open do init()

) -- end of ro_PflowBaker

ro_PflowBaker.openDialog()