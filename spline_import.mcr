macroScript splineImport
	category:"umami"
	toolTip:"spline_import"
(
	
	-- make the material name = to the object name
	global myRescaleAmount = 100
	global thePosObj
	fn addMat = 
		(
		
		Mymat = StandardMaterial ()
		Mymat.name = $.name+"mat"
			m = selectBitmap caption:"Open plate image..."
			matName = getFilenameFile (m.filename)
			diff = bitmapTexture bitmap:m
			
			Mymat.diffuseMap = diff
			$.mat = Mymat
			$.mat.showInViewport = true
			$.mat.opacityMap = diff
			$.mat.opacityMap.monoOutput = 1
			$.name = matName
		
		)

	rollout my_Rollout "SplinePrep" width:162 height:300
	(
		button importbtn "Import Spline" pos:[8,8] width:98 height:24
		button btn2 "Scale Splines" pos:[9,68] width:96 height:24
		spinner spn1 "Scale Amount" pos:[13,40] width:143 height:16 range:[0,100,100] type:#float
		button extrudebtn "Extrude" pos:[12,102] width:91 height:19
		button btn10 "Material" pos:[12,129] width:93 height:17
		on importbtn pressed do
			max file import
		on btn2 pressed do
			rescaleWorldUnits myRescaleAmount #selOnly
		on spn1 changed val do
			myRescaleAmount = val
		on extrudebtn pressed do
		(
			undo on
			(
			myExtrude = Extrude()
			myExtrude.amount = .01
			myExtrude.mapcoords = on
			mySub = subdivide ()
			mySub.size = 0.6
			
			addmodifier $ (myExtrude)
			--addmodifier $ (mySub)
			)
		)
		on btn10 pressed  do
			addMat()
	)
	
rollout AlignRollout "Untitled" width:162 height:300
(
	pickButton btn1 "Pick the Object" pos:[7,7] width:95 height:25
	button btn2 "Align" pos:[5,43] width:99 height:23
	on btn1 picked obj do
		thePosObj = obj
	on btn2 pressed  do
		$.transform = thePosObj.transform
)
	--try(closeRolloutFloater splineprep_floater)catch()
		global splineprep_floater = newRolloutFloater "ShapePrep" 265 265
		 	addRollout my_rollout splineprep_floater
			addRollout AlignRollout splineprep_floater
	
)
