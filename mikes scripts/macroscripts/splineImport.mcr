macroScript splineImport
	category:"Mikes"
	toolTip:"spline_import"
(
	global myRescaleAmount = 100
	global thePosObj
	fn addMat = 
		(
		
		Mymat = standardMaterial()
			m = selectBitmap caption:"Open plate image..."

			diff = bitmapTexture bitmap:m
			
			Mymat.diffuseMap = diff
			$.mat = Mymat
			Mymat.showInViewport = true
			Mymat.opacityMap = diff
			Mymat.opacityMap.monoOutput = 1
		
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
		myExtrude = Extrude()
		myExtrude.amount = .1
		addmodifier $ (myExtrude)
		
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

	my_floater = newRolloutFloater "ShapePrep" 265 265
			addRollout my_rollout my_floater
			addRollout AlignRollout my_floater
)
