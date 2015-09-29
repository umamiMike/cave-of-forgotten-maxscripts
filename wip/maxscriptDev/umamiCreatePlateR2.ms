if roCreatePlate != undefined then destroyDialog roCreatePlate
global myMap
global Test
global roCreatePlate
	
	fn createBitmapPlate constrain width = -- called from btnfile being pressed 
	(
			myMap = selectBitmap caption:"Open plate image..." initialDir:maxFilePath
	
		r = (quat 0.707107 0 0 0.707107) -- sets the rotation to up and forward
		p = Plane pos:[0,0,0] rotation:r -- makes the plane sets pos at world center and sets rotation
		p.lengthsegs = 1 
		p.widthsegs = 1
		
		--routine for getting the apects ratio of the plane and wiring it to always be the same
		w = myMap.width as float
		h = myMap.height as float
		ratio = h / w
		
		p.width = width
		p.length = p.width / ratio	
		
		leftOperationString = "length*" + ((1/ratio) as string)
		rightOperationString = "width*" + (ratio as string)
		
		if (constrain) then
			paramWire.connect2way p.baseObject[#width] p.baseObject[#length] leftOperationString rightOperationString
	
	
			
		
	if $ != undefined then p.transform = $.transform
	else p.transform = (matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0])
	p.isselected = true
	StandardMat p myMap  -- calls the function for the standard map

	)
	
	
--The function for making the plate with a standard material
	
	fn StandardMat theObject theBitmap = (		
		
		test = theBitmap
		mat = standardMaterial()
		diff = bitmapTexture bitmap:theBitmap
		mat.diffuseMap = diff
		matName = getFilenameFile (theBitmap.filename)
		theObject.name =  matName + "_plate"
		mat.name = "Plate_" + matName
		mat.selfIllumAmount = 100
		diff.alphaSource = 0
		diff.monoOutput = 1
		mat.diffusemap.name = theObject.name as string
		mat.Diffuse = color 0 0 0
		mat.Ambient = color 0 0 0
		mat.opacityMap = diff
		mat.showInViewport = true
		mat.opacity = 0
		mat.diffusemap.endCondition = 2
		theObject.material = mat
	
		--p.castshadows = off
		--p.receiveshadows = off
		theObject.material.opacity = 0

		meditmaterials[medit.GetActiveMtlSlot()] = theObject.material

		
	)
	--the function for making the plate with a mental Ray Material
	
	fn MRMat = (
		
	)
			
	rollout roCreatePlate "Create Plate" width:162 height:197
	(
		groupBox grp1 "File Location" pos:[4,7] width:154 height:62
		button btnFile "File..." pos:[12,47] width:140 height:16
		
		spinner spnSize "Size:" pos:[56,74] width:93 height:16 range:[0,9e+010,100] type:#float
		
		checkbox chkConstrain "Constrain Aspect Ratio" pos:[13,95] width:132 height:15 checked:true
		
		radioButtons rdo1 "RadioButtons" pos:[17,120] width:103 height:30 labels:#("RadioButton") default:1 columns:1
	
		on btnFile pressed do(
			undo "Create Bitmap Plate" on CreateBitmapPlate  chkConstrain.checked spnSize.value
					
		)
	)
	


		createDialog roCreatePlate
